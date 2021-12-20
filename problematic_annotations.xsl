<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <xsl:variable name="morpho_tier_name" select="'Morphologie'" /> 
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
   <xsl:template match="@*|node()">
    <xsl:copy> 
      <xsl:apply-templates select="@*|node()" /> 
    </xsl:copy> 
  </xsl:template>
  <xsl:template match="/">
    <ANNOTATED_DOCUMENT>
      <xsl:for-each select="//ALIGNABLE_ANNOTATION">
        <xsl:variable name="id" select="@ANNOTATION_ID" />
        <xsl:variable name="tier_type" select="../../@LINGUISTIC_TYPE_REF" />
        <!-- Transcription -->
        <xsl:variable name="transcription_count" select="fn:count(fn:tokenize(ANNOTATION_VALUE/text(),'\s+'))" />
        <xsl:variable name="transcription_tag">
       	  <xsl:element name="{$tier_type}">
            <xsl:attribute name="count">
              <xsl:value-of select="$transcription_count" />
            </xsl:attribute>
            <xsl:value-of select="ANNOTATION_VALUE" />
       	  </xsl:element>
       	</xsl:variable>
       	<xsl:variable name="query" select="//REF_ANNOTATION[@ANNOTATION_REF=$id]" />
        <xsl:for-each select="$query">
          <xsl:variable name="ref_tier_type" select="../../@LINGUISTIC_TYPE_REF" />
          <xsl:variable name="ref_count" select="fn:count(fn:tokenize(ANNOTATION_VALUE/text(),'\s+'))" />
          <! -- Morphology -->
          <xsl:if test="$ref_tier_type=$morpho_tier_name and $ref_count!=$transcription_count">
            <ANNOTATION id="{$id}">
              <xsl:copy-of select="$transcription_tag" />
              <xsl:element name="{$ref_tier_type}">
                <xsl:attribute name="count">
                  <!--<xsl:value-of select="string-length(normalize-space(ANNOTATION_VALUE))-string-length(translate(normalize-space(ANNOTATION_VALUE),' ','')) +1" />-->
                  <xsl:value-of select="$ref_count" />
                </xsl:attribute>
                <xsl:value-of select="ANNOTATION_VALUE" />
              </xsl:element>
            </ANNOTATION>
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
    </ANNOTATED_DOCUMENT>
  </xsl:template>

</xsl:stylesheet>
