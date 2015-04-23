<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.loc.gov/mods/v3">

    <xsl:template match="photographer">
        <xsl:element name="name">
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
                    <xsl:element name="role">
                        <xsl:element name="roleTerm">
                            <xsl:attribute name="type">code</xsl:attribute>
                            <xsl:attribute name="authority">marcrelator</xsl:attribute>pht</xsl:element>
                        <xsl:element name="roleTerm">
                            <xsl:attribute name="type">text</xsl:attribute>
                            <xsl:attribute name="authority">marcrelator</xsl:attribute>Photographer </xsl:element>
                    </xsl:element>

                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="compare(upper-case(.), 'Unknown')">
                        <xsl:element name="namePart">
                            <xsl:value-of select="."/>
                        </xsl:element>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>