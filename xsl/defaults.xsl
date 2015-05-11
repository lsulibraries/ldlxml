<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.loc.gov/mods/v3"
    version="2.0">

    <xsl:import href="util.xsl"/>

    <!-- Default access template -->
    <xsl:template name="access">
        <xsl:element name="note">
            <xsl:attribute name="type">ownership</xsl:attribute>
            <xsl:value-of select="repository"/>
        </xsl:element>
        <xsl:element name="accessCondition">
            <xsl:attribute name="type">restriction on access</xsl:attribute>
            <xsl:value-of select="restrictions"/>
        </xsl:element>
        <xsl:element name="accessCondition">
            <xsl:attribute name="type">use and reproduction</xsl:attribute>
            <xsl:value-of select="contact-and-ordering-information"/>
        </xsl:element>
    </xsl:template>

    <!--  @TODO - geralize!!  -->
    <!--  Default location template.  -->
    <xsl:template name="location">
        <xsl:element name="location">
            <xsl:element name="physicalLocation">LUU</xsl:element>
            <xsl:element name="physicalLocation">LSU Libraries</xsl:element>
            <xsl:element name="url">http://www.lib.lsu.edu</xsl:element>
            <xsl:element name="holdingSimple">
                <!--will need to be edited for each collection; can add an if statement based on identifier that changes the shelfLocator based on content-->
                <xsl:element name="copyInformation">
                    <xsl:element name="subLocation">Hill Memorial Library, Special Collections</xsl:element>
                    <xsl:element name="shelfLocator">M:22</xsl:element>
                    <!-- Once we have EAD information, we could add it to a holdingExternal element here -->
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <!--  Default recordInfo template.  -->
    <xsl:template name="recordInfo">
        <xsl:element name="identifier">
            <xsl:value-of select="item-number"/>
        </xsl:element>
    </xsl:template>

    <!-- Default subjects template. -->
    <xsl:template name="subjects">
        <xsl:for-each select="tokenize(subjects,';')">
            <xsl:element name="subject">
                <xsl:element name="topic">
                    <xsl:attribute name="authority">LoC</xsl:attribute>
                    <xsl:value-of select="replace(., '^\s+|\s+$', '')"/>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>


    <!-- Default title template. -->
    <xsl:template name="title">
        <xsl:element name="titleInfo">
            <xsl:element name="title">
                <xsl:call-template name="collapse-whitespace">
                    <xsl:with-param name="input" select="."/>
                </xsl:call-template>
            </xsl:element>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>