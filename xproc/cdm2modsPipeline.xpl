<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    <!-- load multiple files from input directory -->
    <p:directory-list path="input"/>
    <p:filter select="//c:file"/>
    <p:for-each name="iterate">
        <p:load>
            <p:with-option name="href" select="concat('input/', /*/@name)"/>
        </p:load>
        <!-- validate with Relax ng -->
        <p:validate-with-relax-ng assert-valid="true">
            <p:input port="schema">
                <p:document href="ValidateCDM.rng" />
            </p:input>
        </p:validate-with-relax-ng>
        
        <!-- mods transform -->
        <!-- mods -->
        <p:rename match="xml" new-name="mods"/>
        <!-- title -->
        <p:wrap wrapper="titleInfo" match="mods/title"/>
        <!-- physicalDescription. note that form and typeOfResource key off photographer - easiest to do it before photographer to mods/name -->
        <p:xslt>
            <p:input port="stylesheet">
                <p:document href="xsl/physical-description.xsl"></p:document>
            </p:input>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
        </p:xslt>
        <!-- photographer to mods/name using util-photographer.xsl (need to make this an if-then for other name types) -->
        <p:xslt>
            <p:input port="stylesheet">
                <p:document href="xsl/util-photographer.xsl"></p:document>
            </p:input>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
        </p:xslt>
        <!-- dateCreated -->
        <p:rename match="mods/date" new-name="dateCreated"/>
        <p:wrap wrapper="originInfo" match="mods/dateCreated" />
        <!-- subjects -->
        <p:xslt>
            <p:input port="stylesheet">
                <p:document href="xsl/subjects.xsl"></p:document>
            </p:input>
            <p:input port="parameters">
                <p:empty/>
            </p:input>
        </p:xslt>
        <!-- identifier -->
        <p:rename match="mods/item_number" new-name="identifier"/>
        <!-- note ownership -->
        <p:rename match="mods/repository" new-name="note"/>
        <p:add-attribute match="mods/note" attribute-name="type" attribute-value="ownership"/>
        <!-- accessCondition -->
        <p:add-attribute match="mods/restrictions" attribute-name="type" attribute-value="restriction on access" />
        <p:rename match="mods/restrictions" new-name="accessCondition"/>
        <p:add-attribute match="mods/contact_and_ordering_information" attribute-name="type" attribute-value="use and reproduction" />
        <p:rename match="mods/contact_and_ordering_information" new-name="accessCondition"/>
        <!-- location needs to be hard-coded? make variables? -->
        <p:rename match="mods/shelving_location" new-name="shelfLocator"/>
        <p:wrap match="mods/shelfLocator" wrapper="copyInformation"/>
        <p:insert match="mods/copyInformation/shelfLocator" position="before">
            <p:input port="insertion">
                <p:inline exclude-inline-prefixes="#all">
                    <subLocation>Hill Memorial Library, Special Collections</subLocation>
                </p:inline>
            </p:input>
        </p:insert>
        <p:wrap match="mods/copyInformation" wrapper="holdingSimple"/>
        <p:wrap match="mods/holdingSimple" wrapper="location"/>
        <p:insert match="mods/location/holdingSimple" position="before">
            <p:input port="insertion">
                <p:inline exclude-inline-prefixes="#all">
                    <physicalLocation>LUU</physicalLocation>
                </p:inline>
                <p:inline exclude-inline-prefixes="#all" >
                    <physicalLocation>LSU Libraries</physicalLocation>                  
                </p:inline>
                <p:inline exclude-inline-prefixes="#all">
                    <url>http://lib.lsu.edu</url>
                </p:inline>
            </p:input>
        </p:insert>

        <!--save multiple files in output directory -->
        <p:store>
            <p:with-option name="href" select="concat('output/', /*/@name)">
                <p:pipe port="current" step="iterate"/>
            </p:with-option>
        </p:store>
    </p:for-each>
</p:declare-step>
    