<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.loc.gov/mods/v3"
    version="2.0">

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

</xsl:stylesheet>