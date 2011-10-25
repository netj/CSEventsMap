<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/rss">
        <xsl:copy>
            <xsl:apply-templates select="channel/item"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="item">
        <conf>
            <xsl:variable name="text" select="replace(description, '&lt;[^&amp;]+?&gt;', '')"/>
            <xsl:variable name="name"   select="normalize-space(substring-before(substring-after($text, '&#10;'), '&#10;'))"/>
            <xsl:variable name="alias"  select="replace(replace($name, '.*\(', ''), '\).*', '')"/>
            <xsl:attribute name="alias" select="replace($alias, '[ -]?(\d{2,4}-\d{2}|\d{2,4})$', '')"/>
            <xsl:attribute name="where" select="normalize-space(substring-before(substring-after($text, 'Location:'), '&#10;'))"/>
            <xsl:variable name="when"  select="normalize-space(substring-before(substring-after($text, 'Date:'), '&#10;'))"/>
            <xsl:attribute name="begin"  select="substring-before($when, ' to ')"/>
            <xsl:attribute name="end"  select="substring-after($when, ' to ')"/>
            <xsl:attribute name="name"  select="$name"/>
        </conf>
    </xsl:template>
</xsl:stylesheet>
