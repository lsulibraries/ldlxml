<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.loc.gov/mods/v3">
    <xsl:import href="lsumarc.xsl"/>
    
    <xsl:template name="filename">
        <xsl:value-of select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
    </xsl:template>
    
    <xsl:template name="ProQuestID">
        <xsl:element name="identifier">
            <xsl:attribute name="type">dewey</xsl:attribute>
            <xsl:value-of
                select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
        </xsl:element>
        
    </xsl:template>
    
    <xsl:template name="physicalDescription">
        <!-- completely useless parameters that must be included for reasons of validation -->
        <xsl:param name="typeOf008"/>
        <xsl:param name="controlField008"/>
        <xsl:param name="leader6"/>
        <xsl:element name="internetMediaType">application/pdf</xsl:element>
        <xsl:element name="digitalOrigin">digitized microfilm</xsl:element>
        <xsl:element name="extent">
            <!-- sample of how extent is handled in loc stylesheet -->
            <!--<xsl:if test="marc:subfield[@code='f']"><xsl:attribute name="unit">
                <xsl:value-of select="local:subfieldSelect(.,'f')"/></xsl:attribute></xsl:if>
            <xsl:value-of select="local:subfieldSelect(.,'abce3g')"/>-->
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>