<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:lsu="http://lsu.edu"
    xmlns="http://www.loc.gov/mods/v3"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- copied from util-date -->
    <xsl:template name="util-name">
        <xsl:param name="raw"/>
        <xsl:param name="roleterm"/>
        <xsl:param name="rolecode"/>
        <xsl:param name="usage" as="xs:string">
            <xsl:text></xsl:text>
        </xsl:param>
        <xsl:param name="description"/>
        <xsl:message> Processing name: <xsl:value-of select="."/>
        </xsl:message>

        <!--instead of fn call-->

        <xsl:call-template name="lsu:namePart">
            <xsl:with-param name="rawName" select="$raw"/>
            <xsl:with-param name="roleType" select="$roleterm"/>
            <xsl:with-param name="roleCode" select="$rolecode"/>
            <xsl:with-param name="usage" select="$usage"/>
            <xsl:with-param name="description" select="$description"/>
        </xsl:call-template>
    </xsl:template>
    
    
    <xsl:template name="lsu:namePart">
        <xsl:param name="rawName" as="xs:string"/>
        <xsl:param name="roleType" as="xs:string"/>
        <xsl:param name="roleCode" as="xs:string"/>
        <xsl:param name="usage" as="xs:string">
            <xsl:text/>
        </xsl:param>
        <xsl:param name="description" as="xs:string"/>
        <xsl:variable name="lsu:lower" select="lower-case(.)"/>
        <xsl:variable name="lsu:family-in-name" select="'family'"/>
        <xsl:variable name="lsu:two-words" select="'[(A-Za-z)+\s]+'"/>
        <!--   Separate family names from other types of name (if = family)-->
        <xsl:choose>
            <xsl:when test="matches($lsu:lower,$lsu:family-in-name)">
                <name type="family">
                    <namePart>
                        <xsl:value-of select="."/>
                    </namePart>
                    <xsl:call-template name="role">
                        <xsl:with-param name="roleterm" select="$roleType"/>
                        <xsl:with-param name="rolecode" select="$roleCode"/>
                    </xsl:call-template>
                    <xsl:element name="description">
                        <xsl:value-of select="$description"/>
                    </xsl:element>
                </name>
            </xsl:when>
            <xsl:when test="lsu:two-words"/>
        </xsl:choose>

        <!-- Separate corportate names with multiple words from other names (if [word] /s [word)=corporate)
        ????
        ????
        -->

        <!-- If personal, do this...-->
        <xsl:variable name="regex" select="'([a-zA-Z\s,]+),\s([0-9?-]+)'"/>

        <xsl:choose>
            <xsl:when test="matches(., $regex)">
                <xsl:element name="name">
                    <xsl:attribute name="type">personal</xsl:attribute>
                    <xsl:attribute name="usage">
                        <xsl:value-of select="$usage"/>
                    </xsl:attribute>
                    <!-- I don't think we can just get rid of line 79 and 80, but we need to change the name of this variable
                        and possibly be more specific about what it selects-->
                    <xsl:variable name="photog" select="."/>

                    <xsl:analyze-string select="$photog" regex="{$regex}">

                        <xsl:matching-substring>
                            <namePart>
                                <xsl:value-of select="regex-group(1)"/>
                            </namePart>
                            <namePart type="date">
                                <xsl:value-of select="regex-group(2)"/>
                            </namePart>
                            <xsl:call-template name="role">
                                <xsl:with-param name="roleterm" select="$roleType"/>
                                <xsl:with-param name="rolecode" select="$roleCode"/>
                            </xsl:call-template>
                        </xsl:matching-substring>
                    </xsl:analyze-string>

                    <xsl:element name="description">
                        <xsl:value-of select="$description"/>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="name">
                    <xsl:if test="compare(upper-case(.), 'Unknown')">
                        <xsl:element name="namePart">
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:if>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="role">
        <xsl:param name="roleterm"/>
        <xsl:param name="rolecode"/>
        <xsl:element name="role">
            <xsl:element name="roleTerm">
                <xsl:attribute name="type">text</xsl:attribute>
                <xsl:attribute name="authority">marcrelator</xsl:attribute>
                <xsl:value-of select="$roleterm"/>
            </xsl:element>
            <xsl:element name="roleCode">
                <xsl:attribute name="type">code</xsl:attribute>
                <xsl:attribute name="authority">marcrelator</xsl:attribute>
                <xsl:value-of select="$rolecode"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>