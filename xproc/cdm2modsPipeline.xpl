<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
    xmlns:c="http://www.w3.org/ns/xproc-step" version="1.0">
    <p:directory-list path="Input"/>
    <p:filter select="//c:file"/>
    <p:for-each name="iterate">
        <p:load>
            <p:with-option name="href" select="concat('input/', /*/@name)"/>
        </p:load>
        <!-- mods -->
        <p:rename match="xml" new-name="mods"/>
        <!-- title -->
        <p:wrap wrapper="titleInfo" match="mods/title"/>
        <!-- accessCondition -->
        <p:add-attribute match="mods/restrictions" attribute-name="type" attribute-value="restriction on access" />
        <p:rename match="mods/restrictions" new-name="accessCondition"/>
        <p:add-attribute match="mods/contact_and_ordering_information" attribute-name="type" attribute-value="use and reproduction" />
        <p:rename match="mods/contact_and_ordering_information" new-name="accessCondition"/>
        <p:store>
            <p:with-option name="href" select="concat('output/', /*/@name)">
                <p:pipe port="current" step="iterate"/>
            </p:with-option>
        </p:store>
    </p:for-each>
</p:declare-step>
    