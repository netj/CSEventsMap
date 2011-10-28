<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/">
        <xsl:text>ConfID</xsl:text>
        <xsl:text>&#9;</xsl:text>
        <xsl:text>Begins</xsl:text>
        <xsl:text>&#9;</xsl:text>
        <xsl:text>Ends</xsl:text>
        <xsl:text>&#9;</xsl:text>
        <xsl:text>Where</xsl:text>
        <xsl:text>&#9;</xsl:text>
        <xsl:text>Title</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates select="*/c"/>
    </xsl:template>

    <xsl:template match="c">
        <xsl:value-of select="@alias"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="@begin"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="@end"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="@where"/>
        <xsl:text>&#9;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
