<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:local="http://netj.org/2011/csconfmap">

    <xsl:output exclude-result-prefixes="local"/>

    <xsl:template match="/dblp">
        <past-conferences>
            <xsl:text>&#10;</xsl:text>
            <xsl:apply-templates select="proceedings[starts-with(@key, 'conf/')]"/>
        </past-conferences>
    </xsl:template>

    <xsl:template match="proceedings">
        <xsl:choose>
            <xsl:when test="matches(@key, '-\d+$')">
                <xsl:if test="matches(@key, '-1$')">
                    <xsl:apply-templates select="." mode="output">
                        <xsl:with-param name="alias" select="replace(booktitle, ' \(.*\)$', '')"/>
                    </xsl:apply-templates>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="output"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="proceedings" mode="output">
        <xsl:param name="alias" select="booktitle"/>
        <xsl:variable name="when"><xsl:call-template name="extract-when"/></xsl:variable>
        <xsl:variable name="where">
            <xsl:call-template name="extract-where">
                <xsl:with-param name="when" select="$when/when[1]/@match"/>
            </xsl:call-template>
        </xsl:variable>
        <!-- for debugging
        <xsl:if test="$when/when">
            <xsl:value-of select="$where/where[1]/@where"/>
            <xsl:text>&#9;</xsl:text>
            <xsl:value-of select="$where/where[1]/@select"/>
            <xsl:text>&#9;</xsl:text>
            <xsl:value-of select="$where/where/@t[1]"/>
            <xsl:text>&#9;</xsl:text>
            <xsl:value-of select="title"/>
            <xsl:text>&#9;</xsl:text>
            <xsl:value-of select="$when/when[1]/@match"/>
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
        <xsl:if test="false()">
        -->
        <xsl:if test="$when/when and $where/where">
            <c>
                <!-- XXX dedup <xsl:attribute name="key"   select="replace(@key, '-1$', '')"/> -->
                <xsl:copy-of select="@key"/>
                <xsl:attribute name="alias" select="$alias"/>
                <xsl:attribute name="where" select="local:normalize-where($where/where[1]/@where)"/>
                <xsl:copy-of select="$when/when[1]/(@begin | @end)"/>
                <xsl:attribute name="url" select="url"/>
                <xsl:value-of select="title"/>
                <!-- XXX couldn't clean up everything: replace(title, ' - Volume [^,]+|, Volume [^,]+|,? Part [I1]+|, (Revised )?Selected Papers$', '')"/> -->
            </c>
        </xsl:if>
    </xsl:template>
    <xsl:variable name="Collations">
        <!-- http://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations -->
        <v o="D.C." x="District of Columbia"/>
        <v x="DC" o="D.C."/>
        <v x="AL" o="Alabama"/>
        <v x="AK" o="Alaska"/>
        <v x="AZ" o="Arizona"/>
        <v x="AR" o="Arkansas"/>
        <v x="CA" o="California"/>
        <v x="CO" o="Colorado"/>
        <v x="CT" o="Connecticut"/>
        <v x="DE" o="Delaware"/>
        <v x="FL" o="Florida"/>
        <v x="GA" o="Georgia"/>
        <v x="HI" o="Hawaii"/>
        <v x="ID" o="Idaho"/>
        <v x="IL" o="Illinois"/>
        <v x="IN" o="Indiana"/>
        <v x="IA" o="Iowa"/>
        <v x="KS" o="Kansas"/>
        <v x="KY" o="Kentucky"/>
        <v x="LA" o="Louisiana"/>
        <v x="ME" o="Maine"/>
        <v x="MD" o="Maryland"/>
        <v x="MA" o="Massachusetts"/>
        <v x="MI" o="Michigan"/>
        <v x="MN" o="Minnesota"/>
        <v x="MS" o="Mississippi"/>
        <v x="MO" o="Missouri"/>
        <v x="MT" o="Montana"/>
        <v x="NE" o="Nebraska"/>
        <v x="NV" o="Nevada"/>
        <v x="NH" o="New Hampshire"/>
        <v x="NJ" o="New Jersey"/>
        <v x="NM" o="New Mexico"/>
        <v x="NY" o="New York"/>
        <v x="NC" o="North Carolina"/>
        <v x="ND" o="North Dakota"/>
        <v x="OH" o="Ohio"/>
        <v x="OK" o="Oklahoma"/>
        <v x="OR" o="Oregon"/>
        <v x="PA" o="Pennsylvania"/>
        <v x="RI" o="Rhode Island"/>
        <v x="SC" o="South Carolina"/>
        <v x="SD" o="South Dakota"/>
        <v x="TN" o="Tennessee"/>
        <v x="TX" o="Texas"/>
        <v x="UT" o="Utah"/>
        <v x="VT" o="Vermont"/>
        <v x="VA" o="Virginia"/>
        <v x="WA" o="Washington"/>
        <v x="WV" o="West Virginia"/>
        <v x="WI" o="Wisconsin"/>
        <v x="WY" o="Wyoming"/>
        <!-- http://en.wikipedia.org/wiki/Canadian_subnational_postal_abbreviations -->
        <v x="AB" o="Alberta"/>
        <v x="BC" o="British Columbia"/>
        <v x="MB" o="Manitoba"/>
        <v x="NB" o="New Brunswick"/>
        <v x="NL" o="Newfoundland and Labrador"/>
        <v x="NS" o="Nova Scotia"/>
        <v x="NT" o="Northwest Territories"/>
        <v x="NU" o="Nunavut"/>
        <v x="ON" o="Ontario"/>
        <v x="PE" o="Prince Edward Island"/>
        <v x="QC" o="Quebec"/>
        <v x="SK" o="Saskatchewan"/>
        <v x="YT" o="Yukon"/>
        <!-- misc. -->
        <v o="UK" x="U.K."/>
        <v o="Korea" x="South Korea"/>
        <v o="Korea" x="Republic of Korea"/>
        <v o="Jeju Island" x="Cheju Island"/>
        <v o="Jeju Island" x="Jeju"/>
        <v o="Xi'an" x="Xian"/>
        <v o="Germany" x="FRG"/>
        <v o="Germany" x="GDR"/>
    </xsl:variable>
    <xsl:function name="local:normalize-where">
        <xsl:param name="where"/>
        <xsl:variable name="normalized" as="xs:string*">
            <xsl:for-each select="tokenize($where, '\s*,\s*')">
                <xsl:variable name="n" select="$Collations/v[@x=current()/.]/@o[1]"/>
                <xsl:value-of select="if ($n) then $n else ."/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="string-join(($normalized), ', ')"/>
    </xsl:function>

    <xsl:template name="extract-when">
        <xsl:param name="title" select="title"/>
        <xsl:variable name="t" select="normalize-space($title)"/>
        <xsl:variable name="year" select="'[0-9]{4}'"/>
        <xsl:variable name="month" select="'[A-Z][a-z]+'"/>
        <xsl:variable name="day" select="'[0-9]{1,2}'"/>
        <xsl:variable name="date-patterns">
            <try regex="\s({$day})\s*-\s*({$day})\s+({$month}),?\s+({$year})" select="$1 $3 $4~$2 $3 $4"/>
            <try regex="\s({$month})\s+({$day})\s*-\s*({$day}),\s+({$year})" select="$2 $1 $4~$3 $1 $4"/>
            <try regex="\s({$day})\s+({$month})\s*-\s*({$day})\s+({$month})\s?,?\s+({$year})" select="$1 $2 $5~$3 $4 $5"/>
            <try regex="\s({$month})\s+({$day})\s*[-,]\s*({$month})\s+({$day}),?\s+({$year})" select="$2 $1 $5~$4 $3 $5"/>
            <try regex="\s({$day})\s+({$month})\s+({$year})\s*-\s*({$day})\s+({$month})\s+({$year})" select="$1 $2 $3~$4 $5 $6"/>
            <try regex="\s({$month})\s+({$day})\s*,\s+({$year})\s*-\s*({$month})\s+({$day})\s?,\s+({$year})" select="$2 $1 $3~$5 $4 $6"/>
            <try regex="\s({$month})\s+({$day})\s*,\s+({$year})" select="$2 $1 $3~$2 $1 $3"/>
            <try regex="\s({$day})\s+({$month})\s+({$year})" select="$1 $2 $3~$1 $2 $3"/>
        </xsl:variable>
        <!-- TODO
noises in <title>
 * beware of Dutch: Magdeburg, 21.-22. M\:urz 2002
 * ..., (...), Proceedings
 * ..., Napa, California, USA
 * April 2002, Napa, CA, Proceedings
 * Harbin, Heilongjiang, China, ...
 * Beijing, China, 11-14 December 2009, Volume 1 - Conference Papers
 * Xi'an, China, December 15-19, 2005, Proceedings, Part I
 * Guangzhou, China, November 3-6, 2006, Revised Selected Papers
 * ECDL 2010, Glasgow, UK, September 6-10, 2010. Proceedings
 * Final Reports$
 * Selected Papers$
 * ..., October 1st, 2001 in Toronto, Canada$
 * Proceedings of the 1996 Information Systems Conference of New Zealand, ISCNZ '96, October 30-31, 1996
 * Kingston, Ontario, Canada
 * TaiChung, Taiwan, March 21 - 24, 2011
 * Mannheim, 21.-23. Juni 1990
                 -->
        <xsl:for-each select="$date-patterns/try">
            <xsl:if test="matches($t, @regex)">
                <when>
                    <xsl:attribute name="match"     select="replace($t, concat('.*(', @regex, ').*'), '$1')"/>
                    <xsl:variable  name="begin-end" select="replace($t, concat('.*', @regex, '.*'), @select)"/>
                    <xsl:attribute name="begin"     select="local:normalize-date(substring-before($begin-end, '~'))"/>
                    <xsl:attribute name="end"       select="local:normalize-date(substring-after($begin-end, '~'))"/>
                </when>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:variable name="LastYear" select="year-from-date(current-date())"/>
    <xsl:function name="local:normalize-date">
        <xsl:param name="datestr"/>
        <xsl:variable name="months" select="'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'"/>
        <xsl:if test="$datestr">
            <xsl:variable name="d" select="tokenize(normalize-space($datestr), '\s+')"/>
            <xsl:number format="0001" value="for $y in number($d[3]) return if ($y &lt; 1960) then (if ($y &lt; 1100) then $y+1000 else 1900+($y mod 100)) else if ($y &gt; $LastYear) then $LastYear else $y"/>
            <xsl:text>-</xsl:text>
            <xsl:number format="01" value="index-of($months, $d[2])"/>
            <xsl:text>-</xsl:text>
            <xsl:number format="01" value="$d[1]"/>
        </xsl:if>
    </xsl:function>

    <xsl:template name="extract-where">
        <xsl:param name="when"/>
        <xsl:param name="title" select="title"/>
        <xsl:variable name="whenMatched" select="normalize-space($when)"/>
        <xsl:if test="$whenMatched">
            <!-- TODO why don't we substring-before/after($t, $when) and then match patterns on each? -->
            <!-- TODO and try detecting with some dictionary of nations and/or cities -->
            <!-- XXX replace( , '([^,.]{38,}|([^,.\s]+\s+){7,}[^,.\s]+)[,.]', '') -->
            <xsl:variable name="t" select="
                normalize-space(
                replace(
                replace(
                replace(
                replace(normalize-space($title)
                , '[.,-] ((\d{1,3}|[A-Z][^,\s]{1,10})\s+){0,5}?(Papers|Lectures|Vol(\.|umes?)|Part|CD-Rom|Tutorial Notes|Reports|Companion Material|Advanced Course)([, ][^,]*)?$', '', 'i')
                , '[.,/-]?\s*(Companion |Preliminary |Pre[ -]?|Post(er)?[ -]?|)Proc{1,2}ee{0,2}[ds]ings?($|[.,])', '', 'i')
                , '[.,/-]?\s*Proc{1,2}ee{0,2}[ds]ings?( of [^,]+| (Volume|Part)[^,.]+)?[.,]', '', 'i')
                , '(\s*\([^),.]+\)?\.?|[\].]+|([.,] (co-?located|conjunction|jointly))[^,.]+)$', '', 'i')
                )
                "/>
            <xsl:variable name="word" select="&quot;(USA|\p{Lu}{2}|D\.C\.|U\.?K\.|GDR|FRG|HKSAR|of|[\p{Lu}d]\p{Ll}+([./,'-](\p{L}\p{Ll}+)?)*)&quot;"/>
            <xsl:variable name="name" select="concat($word, '( ', $word, '){0,3}')"/>
            <xsl:variable name="longerName" select="concat($word, '( ', $word, '){0,6}')"/>
            <xsl:variable name="where-patterns">
                <try regex="{$whenMatched}([,.]|\s+-)\s+([^0-9,.].+)$" select="$2"/>
                <try regex="{$whenMatched}([,.]\s*(at|in)\s+|\s+(-|in)\s+)([^,.].+)$" select="$4"/>
                <try regex="(^|[,.]|\s+(at|in|and|\d{{4}}|\p{{Lu}}+\s+)|\d{{2}})\s*({$longerName}(\s*,\s*{$name}){{0,3}})\s*[.,-]\s*{$whenMatched}$" select="$3"/>
                <try regex="(^|[,.]|\s+(at|in|and|\d{{4}}|\p{{Lu}}+\s+)|\d{{2}})\s*({$longerName}(\s*,\s*{$name}){{0,3}})\s*{$whenMatched}$" select="$3"/>
            </xsl:variable>
            <xsl:for-each select="$where-patterns/try">
                <xsl:if test="matches($t, @regex, 'i')">
                    <where>
                        <xsl:attribute name="where" select="
                            replace(
                            replace(
                            replace(
                            replace(
                            replace($t
                            , concat('.*?', @regex, '.*'), @select, 'i')
                            , '^.*\s+(Advanced Course|Conference|Seminar|Symposium|Colloquium|Summer School|Workshops?|Services|Design|Applications|Analysis|Systems|Informatics|Internet|Computing|Environments?|Databases|Networking|Programming|Languages|Engineering|Tools|Learning|Mining|Intelligence|Theory|Methodologies|Processing|Automation|Computation|Architectures|Approximation|Cryptography|Forensics|Development|Measurement|Expressions|Sciences?|Industry|Retrieval|Security|Modeling|Techniques|Technolog(y|ies)|I|II|III|IV|V|VII|VIII|IX|X|XI|XII)(,\s*|\s+)', '', '')
                            , '^.*?\s*(([^,]+,\s+){1,2}USA).*$', '$1', 'i')
                            , '\s*(/| - .*?|[\[(][^,]+)$', '', 'i')
                            , '^(and|(held )?(in|at)) ', '', 'i')
                            "/>
                        <xsl:attribute name="select" select="replace($t, concat('.*?', @regex, '.*'), @select, 'i')"/>
                        <xsl:attribute name="match" select="replace($t, concat('.*?(', @regex, ').*'), '$1', 'i')"/>
                    </where>
                </xsl:if>
            </xsl:for-each>
            <!-- debug <where t="{$t}"/> -->
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
