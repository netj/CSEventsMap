<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:local="http://netj.org/2011/csconfmap">
    <xsl:template match="/rss">
        <upcoming-conferences>
            <xsl:apply-templates select="channel/item"/>
        </upcoming-conferences>
    </xsl:template>

    <xsl:template match="item">
        <xsl:variable name="text"  select="replace(description, '&lt;[^&amp;]+?&gt;', '')"/>
        <xsl:variable name="name"  select="normalize-space(substring-before(substring-after($text, '&#10;'), '&#10;'))"/>
        <xsl:variable name="alias" select="normalize-space(replace(replace(replace($name, '.*\(', ''), '\).*', ''), '[ -]?(\d{2,4}-\d{2}|\d{2,4})$', ''))"/>
        <xsl:variable name="when"  select="normalize-space(substring-before(substring-after($text, 'Date:'), '&#10;'))"/>
        <xsl:variable name="where" select="normalize-space(substring-before(substring-after($text, 'Location:'), '&#10;'))"/>
        <xsl:variable name="url" select="normalize-space(substring-before(substring-after($text, 'Url:'), '&#10;'))"/>
        <xsl:if test="$alias and $when and $where">
            <c>
                <xsl:attribute name="alias" select="$alias"/>
                <xsl:attribute name="where" select="$where"/>
                <xsl:attribute name="begin" select="local:normalize-date(substring-before($when, ' to '))"/>
                <xsl:attribute name="end"   select="local:normalize-date(substring-after($when, ' to '))"/>
                <xsl:attribute name="url"   select="$url"/>
                <xsl:value-of select="$name"/>
            </c>
        </xsl:if>
    </xsl:template>

    <xsl:function name="local:normalize-date">
        <xsl:param name="datestr"/>
        <xsl:variable name="months" select="'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'"/>
        <xsl:variable name="d" select="tokenize(normalize-space($datestr), '\s+')"/>
        <xsl:if test="count($d) = 3 and number($d[2]) > 0 and number($d[3]) > 0">
            <xsl:text>20</xsl:text>
            <xsl:number format="01" value="$d[3]"/>
            <xsl:text>-</xsl:text>
            <xsl:number format="01" value="index-of($months, $d[1])"/>
            <xsl:text>-</xsl:text>
            <xsl:number format="01" value="$d[2]"/>
        </xsl:if>
    </xsl:function>
</xsl:stylesheet>
