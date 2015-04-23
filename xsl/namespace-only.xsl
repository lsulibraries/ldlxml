<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output indent="yes"/>
    
    
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*" />
        </xsl:copy>
    </xsl:template>
    
    
    <!-- Just change the match="/*" to match="*" ; if you want to add namespace in all elements -->
    <xsl:template match="*">
        <xsl:element name="{local-name()}" namespace="http://www.loc.gov/mods/v3">
            <xsl:apply-templates select="node()|@*" />
        </xsl:element>
    </xsl:template>
     
</xsl:stylesheet>