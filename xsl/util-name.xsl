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
        <xsl:param name="roleType" as="xs:string"/>
        <xsl:variable name="lsu:lower" select="lower-case(.)"/>
        <xsl:variable name="lsu:family-in-name" select="'family'"/>
        <xsl:variable name="lsu:two-words" select="'[(A-Za-z)+\s]+'"/>
        <xsl:choose>
            <xsl:when test="matches($lsu:lower,$lsu:family-in-name)">
                <name type="family">
                    <namePart>
                        <xsl:value-of select="."/>
                    </namePart>
                </name>
            </xsl:when>
            <xsl:when test="lsu:two-words"></xsl:when>
        <!--   Separate family names from other types of name (if = family)-->
        <!--   Fix this (copied from util-date). These values are invalid and should throw an error     -->
        </xsl:choose>
    
    <!-- Separate corportate names with multiple words from other names (if [word] /s [word)=corporate) -->
    
    <!-- If personal, do this...-->
            <xsl:variable name="regex" select="'([a-zA-Z\s,]+),\s([0-9?-]+)'"/>
            
            <xsl:choose>
                <xsl:when test="matches(., $regex)">
                    <xsl:attribute name="type">personal</xsl:attribute>
                    <xsl:attribute name="usage">primary</xsl:attribute>
                    <xsl:variable name="photog" select="."/>
                    
                    <xsl:analyze-string select="$photog" regex="{$regex}">
                        
                        <xsl:matching-substring>
                            <namePart>
                                <xsl:value-of select="regex-group(1)"/>
                            </namePart>
                            <namePart type="date">
                                <xsl:value-of select="regex-group(2)"/>
                            </namePart>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                    
                   <!-- <xsl:element name="role">
                        <xsl:element name="roleTerm">
                            <xsl:attribute name="type">code</xsl:attribute>
                            <xsl:attribute name="authority">marcrelator</xsl:attribute>pht</xsl:element>
                        <xsl:element name="roleTerm">
                            <xsl:attribute name="type">text</xsl:attribute>
                            <xsl:attribute name="authority">marcrelator</xsl:attribute>Photographer </xsl:element>
                    </xsl:element>-->
                    
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="compare(upper-case(.), 'Unknown')">
                        <xsl:element name="namePart">
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
</xsl:stylesheet>