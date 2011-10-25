<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/dblp">
        <xsl:copy>
            <xsl:apply-templates select="proceedings[starts-with(@key, 'conf/')]"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="proceedings">
        <xsl:copy>
            <xsl:copy-of select="@title"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
