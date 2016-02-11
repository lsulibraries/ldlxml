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

    <xsl:template match="physical_description">
        <!--this section may need to recoded based on the structure of each collections' physical description field-->
        <xsl:element name="physicalDescription">
            <xsl:variable name="PhysDesc" select="'([0-9a-zA-Z\s,]+);\s?([0-9\sa-zA-Z.&quot;]+)'"/>
            <xsl:choose>
                <xsl:when test="matches(., ';')">
                    <xsl:analyze-string select="." regex="{$PhysDesc}">
                        <xsl:matching-substring>
                            <note>
                                <xsl:attribute name="type">content</xsl:attribute>
                                <!-- <xsl:value-of select="regex-group(1)"/>-->
                                <xsl:value-of select="replace(regex-group(1), '\s+', ' ')"/>
                            </note>
                            <extent>
                                <!-- <xsl:value-of select="regex-group(2)"/>-->
                                <xsl:value-of select="replace(regex-group(2), '\s+', ' ')"/>
                            </extent>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
                </xsl:when>
                <xsl:otherwise>
                    <note>
                        <xsl:attribute name="type">content</xsl:attribute>
                        <xsl:value-of select="."/>
                    </note>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="empty(ancestor-or-self::mods/photographer)"> </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="form">Photograph/Pictorial Works</xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
        
        <xsl:choose>
            <xsl:when test="empty(ancestor-or-self::mods/photographer)"> </xsl:when>
            <xsl:otherwise>
                <xsl:element name="typeOfResource">still image</xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>



</xsl:stylesheet>