<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns="http://www.loc.gov/mods/v3">
   
    <!-- imports -->
    <xsl:import href="skeleton.xsl"/>
    <xsl:template name="name">
        <xsl:call-template name="author"/>
        <xsl:call-template name="advisor"/>
        <xsl:call-template name="committeeMember"/>
    </xsl:template>

<!-- beginning of actual transformation specs -->
    <xsl:template name="title">
        <xsl:element name="titleInfo">
            <xsl:element name="title">
                <xsl:value-of select="//marc:datafield[@tag='245']/marc:subfield[@code='a']"/>
            </xsl:element>
            <xsl:element name="subTitle">
                <xsl:value-of select="//marc:datafield[@tag='245']/marc:subfield[@code='b']"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!--  -->
    <!--  -->
    <!--  -->
    <!-- continue from here replacing selections with xpaths for subfields -->
    <!--  -->
    <!--  -->
    <!--  -->
    
    
    
    
    <xsl:template name="originInfo">
        <xsl:element name="originInfo">
            <xsl:call-template name="date">
                <xsl:with-param name="raw" select="date-of-interview"/>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>

<xsl:template name="filename">
    <xsl:analyze-string select="//marc:datafield[@tag='998']/marc:subfield[@code='a']" regex="[0-9]">
        <xsl:matching-substring>
            <xsl:value-of select="regex-group(1)"/>
        </xsl:matching-substring>
    </xsl:analyze-string>
</xsl:template>
    
<!-- Old method for creating filenames
    <xsl:template name="filename">
        <xsl:analyze-string select="cite-as" regex="[a-zA-Z,\.\s]+\s([0-9]+\.[0-9]+)">
            <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring/>
        </xsl:analyze-string> -->
<!--        <xsl:result-document method="xml" href="{identifier}.xml"/>
    </xsl:template>-->
    
    <xsl:template name="recordInfo">
        <xsl:element name="identifier">
        <xsl:analyze-string select="cite-as" regex="[a-zA-Z,\.\s]+\s([0-9]+\.[0-9]+)">
            <xsl:matching-substring>
                <xsl:value-of>Mss. </xsl:value-of>
                <xsl:value-of select="regex-group(1)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring/>
        </xsl:analyze-string>
        </xsl:element>
        
    </xsl:template>
    <!-- Templates to which the name utility is applied -->
    <xsl:template name="author">
        <xsl:variable name="rawNames" select="//marc:datafield[@tag='100']/marc:subfield[@code='a']"/>
        <xsl:for-each select="$rawNames">
            <xsl:call-template name="util-name">
                <xsl:with-param name="roleterm" select="'Author'"/>
                <xsl:with-param name="rolecode" select="'aut'"/>
                <xsl:with-param name="usage" select="'primary'"/>
                <xsl:with-param name="raw" select="current()"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="advisor">
       
        <xsl:choose>
            <xsl:when test="//marc:datafield[@tag='500', 'Director:']">
                <!--create something that selects certain text after "Director:" and turns it into a $rawName-->
                        <xsl:variable name="rawNames" select='substring-after="Director:"'/>
                        <xsl:for-each select="$rawNames">
                            <xsl:call-template name="util-name">
                                <xsl:with-param name="roleterm" select="'Thesis advisor'"/>
                                <xsl:with-param name="rolecode" select="'ths'"/>
                                <xsl:with-param name="raw" select="current()"/>
                            </xsl:call-template>   
                        </xsl:for-each>
                    
                
               
            </xsl:when>
        </xsl:choose>
       
    </xsl:template> 
  
    <xsl:template name="committeeMember">
            <xsl:call-template name="util-name">
                <xsl:with-param name="roleterm" select="'Committee member'"/>
                <xsl:with-param name="raw">Unknown</xsl:with-param>
            </xsl:call-template>
        
        <!--  edited out because we don't know if this data exists in the records in any reliable way
        <xsl:variable name="biogNote" select="biographical-note"/>
        <xsl:for-each select="tokenize(interviewee,'; ')">
            <xsl:call-template name="util-name">
                <xsl:with-param name="roleterm" select="'Interviewee'"/>
                <xsl:with-param name="rolecode" select="'ive'"/>
                <xsl:with-param name="usage" select="'primary'"/>
                <xsl:with-param name="raw" select="current()"/>
                <xsl:with-param name="description" select="$biogNote"/>
            </xsl:call-template>   
        </xsl:for-each>
     -->
    </xsl:template> 
          
    <xsl:template name="physicalDescription">
        <!--<xsl:element name="physicalDescription">-->
            <!--<xsl:variable name="PhysDesc" select="'([0-9a-zA-Z\s,]+)\s?'"/>-->
        <xsl:for-each select="tokenize(physical-description, '; ')">
            <xsl:message>
                <xsl:value-of select="current()"/>
            </xsl:message>
            <xsl:analyze-string select="current()" regex="([0-9a-zA-Z\s,]+)\s\(([0-9a-zA-Z\s,]+)">
                <xsl:matching-substring>
                    <xsl:element name="physicalDescription">
                        <note type="content">
                            <xsl:value-of select="regex-group(1)"/>
                        </note>
                        <extent>
                            <xsl:value-of select="regex-group(2)"/>
                        </extent>
                        <xsl:element name="form">Oral History</xsl:element>
                    </xsl:element>
                </xsl:matching-substring>
                <xsl:non-matching-substring/>
            </xsl:analyze-string>
        </xsl:for-each>
        <xsl:element name="typeOfResource">sound recording</xsl:element>
    </xsl:template>
    <xsl:template name="abstract">
        <xsl:element name="abstract">
            <xsl:attribute name="xlink:href"><xsl:value-of select="abstract-"/></xsl:attribute>
            <xsl:value-of select="summary"/>
        </xsl:element>
    </xsl:template>
    <xsl:template name="restrictions-on-access">
        <xsl:attribute name="type">restriction on access</xsl:attribute>
<!--        <xsl:call-template name="restrictions"/>-->
        <xsl:value-of select="copyright"/>
    </xsl:template>
    <xsl:template name="contact-and-ordering-information">
        <xsl:attribute name="type">use and reproduction</xsl:attribute>
        <xsl:value-of select="contact-and-ordering-information-"></xsl:value-of>
    </xsl:template>
    <xsl:template name="access">
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
            <xsl:call-template name="contact-and-ordering-information"/>
        </xsl:element>
    </xsl:template>
    <xsl:template name="location">
        <xsl:element name="location">
            <xsl:element name="physicalLocation">LUU</xsl:element>
            <xsl:element name="physicalLocation">LSU Libraries</xsl:element>
            <xsl:element name="url">http://www.lib.lsu.edu</xsl:element>
            <xsl:element name="holdingSimple">
                <!--will need to be edited for each collection; can add an if statement based on identifier that changes the shelfLocator based on content-->
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
                    <!-- Once we have EAD information, we could add it to a holdingExternal element here -->
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>