<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lsu="http://lsu.edu"
    xmlns="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- copied from util-date -->
    <xsl:template match="name">
        <xsl:variable name="raw" select="."/>
        <xsl:message> Processing name: <xsl:value-of select="."/>
        </xsl:message>

        <!--instead of fn call-->

        <xsl:call-template name="lsu:namePart">
            <xsl:with-param name="rawName" select="$raw"/>
        </xsl:call-template>
    </xsl:template>
    
    
    
    <xsl:template name="lsu:namePart">
        <xsl:param name="rawName" as="xs:string"/>
        
        <!--   Separate family names from other types of name (if = family)-->
        <!--   Fix this (copied from util-date). These values are invalid and should throw an error     -->
        <xsl:variable name="lsu:nd-strict"       select="'^n\.d\.$'"/>
        <xsl:variable name="lsu:unk-strict"      select="'^unknown$'"/>
        <xsl:variable name="lsu:unk-date-strict" select="'^unknown date$'"/>
        <xsl:variable name="lsu:unk-date-leading-zero"   select="'^0.{1,5}$'"/>
        
        
        <xsl:choose>
            <xsl:when test="matches($lsu:date-lower, $lsu:nd-strict) or 
                matches($lsu:date-lower, $lsu:unk-strict) or 
                matches($lsu:date-lower, $lsu:unk-date-strict) or
                matches($lsu:date-lower, $lsu:unk-date-leading-zero)"
                >
                <xsl:value-of select="error(QName('http://lib.lsu.edu', 'Source metadata missing date.'))"/>
            </xsl:when>
        </xsl:choose>
        <!--  end error block-->
    <!-- Separate family names from other types of name (if = family)-->
    
    <!-- Separate corportate names with multiple words from other names (if [word] /s [word)=corporate) -->
    
    <!-- If personal, do this...-->
    
</xsl:stylesheet>