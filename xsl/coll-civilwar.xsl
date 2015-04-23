<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">

    <xsl:template match="/">
        <xsl:copy-of select="node()|@*"/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="subject">
        <xsl:choose>
            <xsl:when test="contains(topic/text(), 'photographer')">
                <xsl:element name="test">
                    <xsl:value-of select="topic"/>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>