<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.loc.gov/mods/v3"
    xmlns:lsu="http://lsu.edu">
    <xsl:import href="lsumarc.xsl"/>
    
    <xsl:template name="filename">
        <xsl:value-of select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
    </xsl:template>
    
    <xsl:template name="ProQuestID">
        <xsl:element name="identifier">
            <xsl:attribute name="type">dewey</xsl:attribute>
            <xsl:value-of
                select="substring(marc:datafield[@tag='998']/marc:subfield[@code='a'],4)"/>
        </xsl:element>
        
    </xsl:template>
    
    <!-- copied local:subfieldSelect and renamed for lsu:namespace -->
    <xsl:function name="lsu:subfieldSelect">
        <xsl:param name="datafield" as="node()"/>
        <xsl:param name="codes"/>
        <!-- Breaks out codes for a for each loop -->
        <xsl:variable name="codeString">
            <xsl:for-each select="$codes">
                <xsl:apply-templates/>
            </xsl:for-each>
        </xsl:variable>
        <!-- Selects and prints out datafield -->
        <xsl:variable name="str">
            <xsl:for-each select="$datafield/child::*[contains($codes,@code)]">
                <xsl:value-of select="concat(.,' ')"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
    </xsl:function>
    
    <xsl:template name="physicalDescription">
        <!-- completely useless parameters that must be included for reasons of validation -->
        <xsl:param name="typeOf008"/>
        <xsl:param name="controlField008"/>
        <xsl:param name="leader6"/>
       <!-- end of useless parameters -->
        
        
        <xsl:element name="physicalDescription">
            <xsl:element name="form">
                <xsl:attribute name="authority">marcform</xsl:attribute>
                print
            </xsl:element>
            <xsl:element name="extent">
                <!-- copied how extent is handled in loc stylesheet -->
                <xsl:if test="marc:subfield[@code='f']"><xsl:attribute name="unit">
                <xsl:value-of select="lsu:subfieldSelect(.,'f')"/></xsl:attribute></xsl:if>
            <xsl:value-of select="lsu:subfieldSelect(.,'abce3g')"/>
                <xsl:template
                    match="marc:datafield[@tag='300'] | marc:datafield[@tag='880']
                    [starts-with(marc:subfield[@code='6'],'300')]"
                    mode="physDesc">
                    
                    <extent>
                        <!-- 3.5 2.18 20142011 -->
                        <xsl:if test="marc:subfield[@code='f']">
                            <xsl:attribute name="unit">
                                <xsl:value-of select="lsu:subfieldSelect(.,'f')"/>
                            </xsl:attribute></xsl:if>
                        <xsl:value-of select="lsu:subfieldSelect(.,'abce3g')"/>
                    </extent>
                </xsl:template>
                <!-- 351 note-->
                <xsl:template match="marc:datafield[@tag='351']" mode="physDesc">
                    <note type="arrangement">
                        <xsl:for-each select="marc:subfield[@code='3']">
                            <xsl:apply-templates/>
                            <xsl:text>: </xsl:text>
                        </xsl:for-each>
                        <xsl:value-of select="lsu:subfieldSelect(.,'abc')"/>
                    </note>
                </xsl:template>
            </xsl:element>
            <xsl:element name="internetMediaType">application/pdf</xsl:element>
            <xsl:element name="digitalOrigin">digitized microfilm</xsl:element>
        </xsl:element>
        
    </xsl:template>
</xsl:stylesheet>