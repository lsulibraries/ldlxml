<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:import href="marc21slimMods3-5.xsl"/>
    <xsl:import href="util-date.xsl"/>
    <xsl:import href="util-name.xsl"/>
    <xsl:output indent="yes"/>
    
    <!--  <xsl:template match="/marc:record">
        <xsl:apply-templates/>
    </xsl:template>-->
    
    <xsl:template match="/">
        
        <xsl:choose>
            <xsl:when test="//marc:collection">
                <modsCollection xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
                    <xsl:for-each select="//marc:collection/marc:record">
                        <xsl:variable name="filename-tmp">
                            <xsl:call-template name="filename"/> <!--   Must be overridden by collection-specific template.   -->
                        </xsl:variable>
                        
                        <xsl:result-document method="xml" href="{$filename-tmp}.xml">
                            
                            <mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                                xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xlink="http://www.w3.org/1999/xlink"
                                xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
                                
                            <xsl:call-template name="marcRecord"/>
                                
                                
                                <!-- need to create something that will replace the other physicalDescription
                                or possibly move the other physicalDescription to inside a "relatedItem" that is print
                                
                                ALSO-Must fix the failure to inherit the namespace-->
                                <xsl:call-template name="physicalDescription"/>
                              
                        </mods>
                        </xsl:result-document>
                    </xsl:for-each>
                </modsCollection>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="/marc:record">
                    <xsl:variable name="filename-tmp">
                        <xsl:call-template name="filename"/> <!--   Must be overridden by collection-specific template.   -->
                    </xsl:variable>
                    
                    <xsl:result-document method="xml" href="{$filename-tmp}.xml">
                <mods xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.5"
                    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
                    <xsl:for-each select="/marc:record">
                        <xsl:call-template name="marcRecord"/>
                    </xsl:for-each>
                </mods>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="filename">
        <xsl:value-of select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
    </xsl:template>
    
    <xsl:template name="proquestid">
        <xsl:element name="identifier">
            <xsl:attribute name="type">proquestID</xsl:attribute>
        <xsl:value-of select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="localIDorOCLC">
        <xsl:variable name="OCLCocm" select="'(^ocm)'"/>
        <xsl:choose>
            <xsl:when test="matches(/marc:datafield[@tag='001']/marc:subfield[@code='a'],$OCLCocm)">
                <xsl:element name="identifier">
                    <xsl:attribute name="type">OCLC</xsl:attribute>
                    <xsl:value-of select="substring(marc:datafield[@tag='001']/marc:subfield[@code='a'],4)"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="identifier">
                    <xsl:attribute name="type">localID</xsl:attribute>
                    <xsl:value-of select="(marc:datafield[@tag='001']/marc:subfield[@code='a'])"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--  add something <identifier type="callnumber">378.76L930D 1941 FLOW</identifier>-->
    
    <xsl:template name="physicalDescription">
        <xsl:element name="physicalDescription">
        <xsl:element name="form">electronic</xsl:element>
        <xsl:element name="internetMediaType">application/pdf</xsl:element>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>

