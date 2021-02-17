<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html"/>

    <xsl:template name="repeat">
        <xsl:param name="output"/>
        <xsl:param name="count"/>
        <xsl:if test="$count &gt; 0">
            <li>
                <i class="fa fa-star">&#160;</i>
            </li>
            <xsl:call-template name="repeat">
                <xsl:with-param name="count" select="$count - 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="/">
        <div class="reviews-list">
            <xsl:for-each select="//review">
                <div class="media" id="review-{@id}">
                    <ul class="w3l-ratings pull-right">
                        <xsl:call-template name="repeat">
                            <xsl:with-param name="count" select="stars"/>
                        </xsl:call-template>
                    </ul>
                    <div class="media-body">
                        <h4 class="media-heading user_name">
                            <xsl:value-of select="name"/>
                        </h4>
                        <h5 class="review_content">
                            <xsl:value-of select="comment"/>
                        </h5>
                        <p>
                            <small>
                                <a href="javascript:edit({@id})">Edit</a>
                                -
                                <a href="javascript:remove_review({@id})">Delete</a>
                            </small>
                        </p>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
</xsl:stylesheet>