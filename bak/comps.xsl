<?xml version="1.0" ?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#160;"> ]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/>
<xsl:variable name="ver">9</xsl:variable>
<!--
###############################################################################
# $Id: comps.xsl,v 1.3 2003/09/02 09:18:44 deatrich Exp $
# FILE:         comps.xsl
# PURPOSE:      transform the comps.xml file into something more visual
# 
# AUTHOR:       D. Deatrich
# DATE:         20 Feb 03
# CHANGES:      21/02/03 - DCD	- fix oversight: add 'langonly' element
#				- add total counts to the top
#				- add $ver variable
#
# NOTES:        
###############################################################################
 -->

<xsl:template match="comps">
 <html>
<!-- name of stylesheet and base file are hardcoded in this doc. as:
     comps.css and comps.html
 -->
 <head>
  <title>Red Hat <xsl:value-of select="$ver"/> comps.xml File</title>
  <link rel="stylesheet" href="comps.css" />
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <meta name="author" content="Denice Deatrich" />
  <meta name="license" content="Public Domain" />
  <meta name="poetry" content="This is a learning tool, scooby b doo b dool" />
  <meta name="disclaimer" content="It's not my fault!" />
 </head>
<!--
We decide to do everything in for-each loops, so that we can have
complete control over output ordering.
 -->
 <body>
 <h1>Red Hat <xsl:value-of select="$ver"/> COMPS File: XML Structures</h1>
<!-- first create 2 links to places further down in the doc. -->
 <a class="name">
   <xsl:attribute name="href">
   <xsl:value-of select="comps.html"/>
   <xsl:text>#major-hier</xsl:text>
   </xsl:attribute>
   <!-- the 'group hierarchy' tags return logical groupings of packages -->
   Group Hierarchy Links
 </a><br/>
 <a class="name">
   <xsl:attribute name="href">
   <xsl:value-of select="comps.html"/>
   <xsl:text>#major-pkg</xsl:text>
   </xsl:attribute>
   <!-- the 'package' tags are at the end of the doc -->
   Package Links
 </a>
 <p>Number of groups provided:
   <xsl:value-of select="count(//group)" />
 </p>
 <p>Number of packages provided:
   <xsl:value-of select="count(//package)" />
 </p>
 <hr/>
 <h1>Red Hat <xsl:value-of select="$ver"/> COMPS File: GROUP LINKS</h1>
   <div class="group">
   <table width="100%">
   <tr>
   <td>
   <!-- we will loop thru the groups twice; once to throw a bunch of
        quick links at the top of the file, and again to present each
        group in detail
    -->
   <xsl:for-each select="group/id">
     <xsl:sort select="."/>
     <xsl:call-template name="hreflink">
      <xsl:with-param name="special">grp-</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
   </xsl:for-each>
   </td>
   </tr>
   </table>
   </div>
 <hr/>
 <h1>Red Hat <xsl:value-of select="$ver"/> COMPS File: GROUP DETAILS</h1>
 <span class="note">(Groups appear in file order)</span>
   <!-- this loop will output group details -->
   <xsl:for-each select="group">
     <div class="group">
     <table width="100%">
     <tr>
     <td width="15%" class="name">
     <xsl:number value="position()" format="1"/>.
     </td>
     <td class="name">
     <span class="group">
      <xsl:call-template name="namelink">
         <xsl:with-param name="special">grp-</xsl:with-param>
      </xsl:call-template>
     </span>
     (<em><xsl:value-of select="id"/></em>)
     </td>
     </tr>
     <tr>
     <td class="name"> Description:</td>
     <td>
     <span class="desc"><xsl:value-of select="description"/>
     </span>
     </td>
     </tr>
     <tr>
     <td class="name"> Features:</td>
     <td>
     <xsl:choose>
       <xsl:when test="default[text() = 'true']">
       Default,
       </xsl:when>
       <xsl:otherwise>
       Optional,
       </xsl:otherwise>
     </xsl:choose>
     <!-- hmmm. should be a better check than this? -->
     <xsl:choose>
       <xsl:when test="langonly[text() != '']">
       Language Only,
       </xsl:when>
       <xsl:otherwise>
       </xsl:otherwise>
     </xsl:choose>
     <xsl:choose>
       <xsl:when test="uservisible[text() = 'true']">
       Visible
       </xsl:when>
       <xsl:otherwise>
       Hidden
       </xsl:otherwise>
     </xsl:choose>
     </td>
     </tr>
     <tr>
     <td class="name"> Group List:</td>
     <td>
     <span class="mandatory">Required: </span><xsl:text> </xsl:text>
     <!-- loop thru group list -->
     <xsl:for-each select="grouplist/groupreq">
       <xsl:call-template name="hreflink">
      <xsl:with-param name="special">grp-</xsl:with-param>
     </xsl:call-template>
       <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
     </xsl:for-each>
     <!-- loop thru group list -->
     <xsl:if test="count(grouplist/metapkg)>0">
       <span class="default">&nbsp;Meta packages: </span><xsl:text> </xsl:text>
       <xsl:for-each select="grouplist/metapkg">
         <xsl:call-template name="hreflink"/>
         <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
       </xsl:for-each>
     </xsl:if>
     </td>
     </tr>
     </table>
     <p>
     <table border="1" width="100%">
     <tr> <th colspan="3">Package List</th> </tr>
     <tr> <th width="33%">Mandatory</th>
          <th width="33%">Default</th>
          <th>Optional</th>
     </tr>
     <tr>
     <!-- loop thru mandatory pkg list -->
     <td>
     <xsl:text>&nbsp;</xsl:text>
     <xsl:for-each select="packagelist/packagereq[@type='mandatory']">
       <xsl:call-template name="hreflink"/>
       <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
     </xsl:for-each>
     </td>

     <!-- loop thru default pkg list -->
     <td>
     <xsl:text>&nbsp;</xsl:text>
     <xsl:for-each select="packagelist/packagereq[@type='default']">
       <xsl:sort select="."/>
       <xsl:call-template name="hreflink"/>
       <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
     </xsl:for-each>
     </td>

     <!-- loop thru optional pkg list -->
     <td>
     <xsl:text>&nbsp;</xsl:text>
     <xsl:for-each select="packagelist/packagereq[@type='optional']">
       <xsl:sort select="."/>
       <xsl:call-template name="hreflink"/>
       <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
     </xsl:for-each>
     </td>
     </tr>
     </table>
     </p>
     </div>
   </xsl:for-each>
   <!-- group elements are finished here -->
 <hr/>
 <h1>
 <a>
   <xsl:attribute name="name">
   <xsl:text>major-hier</xsl:text>
   </xsl:attribute>
   Red Hat <xsl:value-of select="$ver"/> COMPS File: GROUP HIERARCHIES
 </a>
 </h1>
 <!-- now we present the group categories -->
 <table class="hier">
 <tr><th width="15%">Group Category</th><th>Groups</th></tr>
 <xsl:for-each select="grouphierarchy/category">
   <tr>
   <td width="15%" class="name"><xsl:value-of select="name"/></td>
   <!-- loop thru subcat lists -->
   <td>
   <xsl:for-each select="subcategories/subcategory">
     <xsl:call-template name="hreflink">
      <xsl:with-param name="special">grp-</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
   </xsl:for-each>
   </td>
   </tr>
 </xsl:for-each>
 </table>
 <hr/>
 <h1>
 <a>
   <xsl:attribute name="name">
   <xsl:text>major-pkg</xsl:text>
   </xsl:attribute>
   Red Hat <xsl:value-of select="$ver"/> COMPS File: PACKAGES
 </a>
 </h1>
<!-- it would be easy to generate another xml doc from the actual RPMs, and
     use it to generate links to more complete info. about the RPM contents
     below... something to think about...
 -->
 <table class="pkg" border="1">
 <!-- finally we present the packages and their deps. -->
 <tr><th width="15%">Package Name</th><th>Dependencies</th></tr>
 <xsl:for-each select="package">
   <xsl:sort select="."/>
   <tr>
   <td>
   <xsl:call-template name="namelink-pkg"/>
   </td>
   <td>
   <xsl:text>&nbsp;</xsl:text>
   <xsl:for-each select="dependencylist/dependency">
     <xsl:call-template name="hreflink"/>
     <xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
   </xsl:for-each>
   </td>
   </tr>
 </xsl:for-each>
 </table>
 <hr/>
<!-- <xsl:apply-templates/> -->
 </body>
 </html>
</xsl:template>

<!-- XML functions -->
<xsl:template name="namelink">
 <xsl:param name="special"> </xsl:param>
 <xsl:variable name="thisid">
   <xsl:value-of select="id"/>
 </xsl:variable>
 <xsl:variable name="tag" select="concat($special,$thisid)" />
 <xsl:if test="id">
 <a>
   <xsl:attribute name="name">
     <xsl:value-of select="$tag"/>
   </xsl:attribute>
   <xsl:value-of select="name"/>
 </a>
 </xsl:if>
</xsl:template>

<xsl:template name="namelink-pkg">
 <xsl:if test="name">
 <a>
   <xsl:attribute name="name">
     <xsl:value-of select="name"/>
   </xsl:attribute>
   <xsl:value-of select="name"/>
 </a>
 </xsl:if>
</xsl:template>

<xsl:template name="hreflink">
 <xsl:param name="name"><xsl:value-of select="."/></xsl:param>
 <xsl:param name="special"> </xsl:param>
 <xsl:variable name="tag" select="concat($special,$name)" />
 <a>
   <xsl:attribute name="href">
     <xsl:value-of select="comps.html"/>
     <xsl:text>#</xsl:text>
     <xsl:value-of select="$tag"/>
   </xsl:attribute>
   <xsl:value-of select="."/>
 </a>
</xsl:template>

<!-- eat these - these rules not used, except during previous debugging
     with 'apply-template' rules which have since been removed
 -->
<xsl:template match="//name[@xml:lang]" />
<xsl:template match="//description[@xml:lang]" />

</xsl:stylesheet>
