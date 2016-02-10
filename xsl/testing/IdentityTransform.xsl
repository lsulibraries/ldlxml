<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- imports -->
    <xsl:import href="MARC21slim_MODS3-5_XSLT2-0.xsl"/>
    <xsl:import href="util-date.xsl"/>
    <xsl:import href="util-name.xsl"/>
    <xsl:output indent="yes"/>
    
    <!-- Canonical identity transform -->

	<xsl:template match="@*">
		<xsl:copy>
		    <mods xmlns="http://www.loc.gov/mods/v3"
		        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		        xmlns:mods="http://www.loc.gov/mods/v3"
		        xmlns:xlink="http://www.w3.org/1999/xlink"
		        xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd"
		        >
		        <xsl:apply-templates select="." />
		    </mods>
		</xsl:copy>
	</xsl:template>        

</xsl:stylesheet>