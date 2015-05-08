<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
   
    <!-- imports -->
    <xsl:import href="_core.xsl"/>

    <xsl:template name="originInfo">
        <xsl:element name="originInfo">
            <xsl:call-template name="date">
                <xsl:with-param name="raw" select="date-of-interview"/>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>

    <xsl:template name="filename">
        <xsl:analyze-string select="cite-as" regex="[a-zA-Z,\.\s]+\s([0-9]+\.[0-9]+)">
            <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring/>
        </xsl:analyze-string>
<!--        <xsl:result-document method="xml" href="{identifier}.xml"/>-->
    </xsl:template>
</xsl:stylesheet>