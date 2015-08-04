<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns="http://www.loc.gov/mods/v3">
   
    <!-- imports -->
    <xsl:import href="skeleton.xsl"/>
      
    
<!-- Things that appear to work -->
    <xsl:template name="title">
        <xsl:element name="titleInfo">
            <xsl:element name="title">
                <xsl:value-of select="title"/>
            </xsl:element>
            <xsl:element name="subTitle">
                <xsl:value-of select="date"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="originInfo">
        <xsl:element name="originInfo">
            <xsl:call-template name="date">
                <xsl:with-param name="raw" select="date"/>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>

    <xsl:template name="filename">
        
                    <xsl:value-of select="date"/>
           
<!--        <xsl:result-document method="xml" href="{identifier}.xml"/>-->
    </xsl:template>
    
  <xsl:template name="name">
      <!-- add information about name-model after interviewer? since editors? -->
  </xsl:template>
        
    <xsl:template name="physicalDescription">
        
        
                <xsl:value-of select="physical-description"/>
            
        <xsl:element name="typeOfResource">text</xsl:element>
    </xsl:template>
    
    <xsl:template name="restrictions-on-access">
        <xsl:attribute name="type">restriction on access</xsl:attribute>
<!--        <xsl:call-template name="restrictions"/>-->
        <xsl:value-of select="restrictions"/>
    </xsl:template>
    <xsl:template name="contact-and-ordering-information">
        <xsl:attribute name="type">use and reproduction</xsl:attribute>
        <xsl:value-of select="contact-and-ordering-information-"></xsl:value-of>
    </xsl:template>
<!--    <xsl:template name="access">
        <xsl:element name="note">
            <xsl:attribute name="type">ownership</xsl:attribute>
            <xsl:value-of select="repository"/>
        </xsl:element>
        <xsl:element name="accessCondition">
            <xsl:attribute name="type">restriction on access</xsl:attribute>
            <xsl:call-template name="restrictions-on-access"/>
        </xsl:element>
        <xsl:element name="accessCondition">
            <xsl:attribute name="type">use and reproduction</xsl:attribute>
            <!-\- create a value-of for use and reproduction? -\->
        </xsl:element>
    </xsl:template>
    <xsl:template name="location">
        <xsl:element name="location">
            <xsl:element name="physicalLocation">LUU</xsl:element>
            <xsl:element name="physicalLocation">LSU Libraries</xsl:element>
            <xsl:element name="url">http://www.lib.lsu.edu</xsl:element>
            <xsl:element name="holdingSimple">
                <!-\-will need to be edited for each collection; can add an if statement based on identifier that changes the shelfLocator based on content-\->
                <xsl:element name="copyInformation">
                    <xsl:element name="subLocation">Hill Memorial Library, Special
                        Collections</xsl:element>
                    <xsl:element name="shelfLocator">
                        <xsl:value-of>L:
                        <xsl:analyze-string select="cite-as" regex="[a-zA-Z,\.\s]+\s([0-9]+\.[0-9]+)">
                            <xsl:matching-substring>
                                <xsl:value-of select="regex-group(1)"/>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring/>
                        </xsl:analyze-string>
                        </xsl:value-of>
                    </xsl:element>
                    <!-\- Once we have EAD information, we could add it to a holdingExternal element here -\->
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
-->
</xsl:stylesheet>