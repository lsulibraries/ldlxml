<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
   
    <!-- imports -->
    <xsl:import href="_core.xsl"/>
    <xsl:import href="util-date.xsl"/>
    <xsl:template match="date-of-interview">
        <xsl:call-template name="date"/>
    </xsl:template>
    <xsl:template name="filename">
        <xsl:analyze-string select="cite-as" regex="'(Mss\.\s+)([0-9]+\.[0-9]+)">
            <xsl:matching-substring>
                <xsl:element name="identifier">
                    <xsl:value-of select="regex-group(1)"/>
                    <xsl:value-of select="regex-group(2)"/>
                </xsl:element>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="error(QName('http://lib.lsu.edu', 'Cite-as field missing a manuscript number.'))"/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        <xsl:result-document method="xml" href="{identifier}.xml"/>
    </xsl:template>
</xsl:stylesheet>