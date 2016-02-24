<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
   
    <xsl:template match="digital_collection">
        <relatedItem type="host">
            <titleInfo>
                <title>
                    <xsl:value-of select="."/>
                </title>
            </titleInfo>
            <location>
                <url note="Finding Aid">
                    <xsl:value-of select="substring-after(//repository_collection_guide,'Finding Aid: ')"/>
                </url>
            </location>
        </relatedItem>
    </xsl:template>
    
</xsl:stylesheet>