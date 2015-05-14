<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xmlns="http://www.loc.gov/mods/v3">
   
    <!-- imports -->
    <xsl:import href="_hard_core.xsl"/>
    <xsl:template name="name">
        <xsl:call-template name="interviewer"/>
        <xsl:call-template name="interviewee"/>
    </xsl:template>
    
<!-- Things that appear to work -->
    <xsl:template name="title">
        <xsl:element name="titleInfo">
            <xsl:element name="title">
                <xsl:value-of select="series"/>
            </xsl:element>
            <xsl:element name="subTitle">
                <xsl:value-of select="title"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
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
    <!-- These two templates (interviewee and interviewer) seem to be interfering with each other -->
    <xsl:template name="interviewer">
       <!-- <xsl:variable name="rawNames" select="tokenize(interviewer,'; ')"/>-->
        <xsl:for-each select="tokenize(interviewer,'; ')">
         <xsl:call-template name="util-name">
             <xsl:with-param name="roleterm" select="'Interviewer'"/>
             <xsl:with-param name="rolecode" select="'ivr'"/>
             <xsl:with-param name="raw" select="current()"/>
         </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="interviewee">
        <!--<xsl:variable name="rawNames" select="tokenize(interviewee,'; ')"/>-->
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
    <xsl:template name="restrictions">
        <xsl:attribute name="type">restriction on access</xsl:attribute>
<!--        <xsl:call-template name="restrictions"/>-->
        <xsl:value-of select="copyright"/>
    </xsl:template>
    <xsl:template name="access">
        <xsl:element name="note">
            <xsl:attribute name="type">ownership</xsl:attribute>
            <xsl:value-of select="repository"/>
        </xsl:element>
        <xsl:element name="accessCondition">
            <xsl:attribute name="type">restriction on access</xsl:attribute>
            <xsl:call-template name="restrictions"/>
        </xsl:element>
        <xsl:element name="accessCondition">
            <xsl:attribute name="type">use and reproduction</xsl:attribute>
            <xsl:value-of select="contact-and-ordering-information"/>
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