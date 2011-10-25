<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/dblp">
        <past-conferences>
            <xsl:apply-templates select="proceedings[starts-with(@key, 'conf/')]"/>
        </past-conferences>
    </xsl:template>

    <xsl:template match="proceedings">
        <xsl:choose>
            <xsl:when test="matches(@key, '-\d+$')">
                <xsl:if test="matches(@key, '-1$')">
                    <c>
                        <!-- XXX dedup <xsl:attribute name="key"   select="replace(@key, '-1$', '')"/> -->
                        <xsl:copy-of select="@key"/>
                        <xsl:attribute name="alias" select="replace(booktitle, ' \(.*\)$', '')"/>
                        <xsl:value-of select="title"/>
                        <!-- XXX couldn't clean up everything: replace(title, ' - Volume [^,]+|, Volume [^,]+|,? Part [I1]+|, (Revised )?Selected Papers$', '')"/> -->
                    </c>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <c>
                    <xsl:copy-of select="@key"/>
                    <xsl:attribute name="alias" select="booktitle"/>
                    <xsl:value-of select="title"/>
                </c>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
