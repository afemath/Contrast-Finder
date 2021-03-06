<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<compress:html>
    <%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    <%@taglib  prefix="form"   uri="http://www.springframework.org/tags/form" %>
    <%@taglib  prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <%@include file='/WEB-INF/template/template_variables.jspf' %>
    <html lang="${lang}">
        <%@include file='/WEB-INF/template/head.jspf' %>
        <body id="contrast-finder-page">
            <div class="container">

                <%-- ===== HEADER ========================================================================================= --%>
                <%@include file='/WEB-INF/template/header.jspf' %>

                <%-- Firefox addon --%>
                <%-- <%@include file='/WEB-INF/template/cf-message.jspf' %>--%>

                <%-- DEBUG   contrast-finder.conf  --%>
                <c:if test="${env == 'debug'}">
                    <div style="background-color:pink; padding: 0.4em;">
                        env              <strong> ${env}                        </strong> <br>
                        defaultAlgorithm <strong> ${defaultAlgorithm}           </strong> <br>
                        cookie.algo      <strong> ${cookie.algo.value}          </strong> <br>
                        algo             <strong> ${algo}                       </strong> <br>
                    </div>
                </c:if>


                <%-- ===== FORM ========================================================================================= --%>
                <div id="set-up-form" class="row">
                    <div class="col-lg-12">
                        <h2><fmt:message key="form.fillInFields"/></h2>
                        <c:set var="actionUrl">
                            <c:url value="result.html"></c:url>
                        </c:set>
                        <form:form class="form-horizontal" name="formulaire" commandName="colorModel" method="GET"  action="${actionUrl}">

                            <%-- Foregound --%>
                            <c:set var="foregroundOnError">
                                <form:errors path="foreground"/>
                            </c:set>
                            <c:choose>
                                <c:when test="${not empty foregroundOnError}">
                                    <c:set var="foregroundOnError" value="has-error"/>
                                    <c:set var="foregroundSampleClass"  value=""/>
                                    <c:set var="foregroundSampleStyle"  value="background-color:rgba(0,0,0,0);"/>
                                    <c:set var="foregroundInvalidStyle" value="display:inherit;"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="foregroundSampleClass"  value="color-sample sample-bordered"/>
                                    <c:set var="foregroundSampleStyle"  value="background-color:${colorModel.foreground};"/>
                                    <c:set var="foregroundInvalidStyle" value="display:none;"/>
                                </c:otherwise>
                            </c:choose>
                            <div class="form-group ${foregroundOnError}">
                                <label for="foreground-input" class="col-lg-3 control-label"><fmt:message key="form.foregroundColor"/></label>
                                <div class="col-lg-4">
                                    <form:input id="foreground-input" path="foreground" type="text" class="form-control"/>
                                    <span class="help-block"><fmt:message key="form.help"/></span>
                                </div>
                                <div id="foreground-sample" class="col-lg-2 ${foregroundSampleClass}" style="${foregroundSampleStyle}">
                                    <span id="foreground-sample-invalid" style="${foregroundInvalidStyle}" class="invalid-color"><fmt:message key="form.invalidColor"/></span>
                                </div>
                            </div>

                            <%-- Background --%>
                            <c:set var="backgroundOnError">
                                <form:errors path="background"/>
                            </c:set>
                            <c:choose>
                                <c:when test="${not empty backgroundOnError}">
                                    <c:set var="backgroundOnError" value="has-error"/>
                                    <c:set var="backgroundSampleClass"  value=""/>
                                    <c:set var="backgroundSampleStyle"  value="background-color:rgba(0,0,0,0);"/>
                                    <c:set var="backgroundInvalidStyle" value="display:inherit;"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="backgroundSampleClass"  value="color-sample sample-bordered"/>
                                    <c:set var="backgroundSampleStyle"  value="background-color:${colorModel.background};"/>
                                    <c:set var="backgroundInvalidStyle" value="display:none;"/>
                                </c:otherwise>
                            </c:choose>
                            <div class="form-group ${backgroundOnError}">
                                <label for="background-input" class="col-lg-3 control-label"><fmt:message key="form.backgroundColor"/></label>
                                <div class="col-lg-4">
                                    <form:input id="background-input" path="background" type="text" class="form-control"/>
                                    <span class="help-block"><fmt:message key="form.help"/></span>
                                </div>
                                <div id="background-sample" class="col-lg-2 ${backgroundSampleClass}" style="${backgroundSampleStyle}">
                                    <span id="background-sample-invalid" style="${backgroundInvalidStyle}" class="invalid-color"><fmt:message key="form.invalidColor"/></span>
                                </div>
                            </div>

                            <%-- Ratio --%>
                            <c:set var="ratioOnError">
                                <form:errors path="ratio"/>
                            </c:set>
                            <c:choose>
                                <c:when test="${not empty ratioOnError}">
                                    <c:set var="ratioOnError" value="has-error"/>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                            <div class="form-group ${ratioOnError}">
                                <label for="ratio" class="col-lg-3 control-label"><fmt:message key="form.ratio"/></label>
                                <div class="col-lg-4">
                                    <form:select class="form-control" path="ratio">
                                        <form:option value="3"></form:option>
                                        <form:option value="4.5"></form:option>
                                        <form:option value="7"></form:option>
                                    </form:select>
                                    <form:errors path="ratio" cssClass="help-block"/>
                                </div>
                            </div>
                            <!-- /col-lg-4 -->


                            <%-- Component to modify --%>
                            <div class="form-group">
                                <label for='isBackgroundTested' class="col-lg-3 control-label"><fmt:message key="form.component"/></label>
                                <div class="col-lg-4">
                                    <form:select class="form-control" path="isBackgroundTested">
                                        <form:option value="false"><fmt:message key="form.componentForeground"/></form:option>
                                        <form:option value="true"><fmt:message key="form.componentBackground"/></form:option>
                                    </form:select>
                                </div>
                            </div>

                            <%-- Choose alorithm --%>
                            <c:set var="algoOnError">
                                <form:errors path="algo"/>
                            </c:set>
                            <c:choose>
                                <c:when test="${not empty algoOnError}">
                                    <c:set var="algoOnError" value="has-error"/>
                                </c:when>
                                <c:otherwise>
                                </c:otherwise>
                            </c:choose>
                            <div class="form-group ${algoOnError}">
                                <fieldset>
                                    <legend class="col-lg-3 control-fieldset"><fmt:message key="form.objectifs"/></legend>
                                    <div class="col-lg-4">
                                        <div class="cf-group-fields">
                                            <div class="radio first-radio">
                                                <label for="algo1">
                                                    <form:radiobutton id="algo1" path="algo" value="HSV"/>
                                                    <fmt:message key="form.algoHSV"/>
                                                </label>
                                            </div>
                                            <div class="radio">
                                                <label for="algo2">
                                                    <form:radiobutton id="algo2" path="algo" value="Rgb"/>
                                                    <fmt:message key="form.algoRGB"/>
                                                </label>
                                            </div>
                                        </div>
                                        <c:if test="${algoOnError == 'has-error'}">
                                            <span class="help-block"><fmt:message key="form.invalidAlgo"/></span>
                                        </c:if>
                                    </div>
                                </fieldset>
                            </div>



                            <div class="form-group">
                                <fmt:message key="form.validate" var="validateButton"/>
                                <input id="submit-button" type="submit" class="btn btn-default btn-lg col-lg-offset-3 col-lg-3" value="${validateButton}"/>
                            </div>
                        </form:form>
                    </div><!-- class="col-lg-12' -->
                </div><!-- class="row' -->



                <c:if test="${not empty colorResult}">
                    <c:choose>
                        <%-- ===== Contrast OK ========================================================================================= --%>
                        <%-- Good contrast: nothing to do --%>
                        <c:when test="${colorResult.combinaisonValid}">
                            <div class="row">
                                <div class="alert-message block-message">
                                    <div class="result col-lg-12">
                                        <h2><fmt:message key="form.validContrast"/>${colorResult.submittedCombinaisonColor.contrast}</h2>
                                        <p><fmt:message key="form.validContrastDesc"/></p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="result col-lg-12">
                                    <img src="<c:url value="Images/good.jpg"/>" alt="Correct contrast"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12" id="image-reference">
                                    <a rel="nofollow" title="Creative Commons Attribution 3.0 License" href="https://creativecommons.org/licenses/by/3.0/">
                                        <img src="<c:url value="Images/creative_common_logo.png"/>" alt="License"> </a>
                                    <a rel="nofollow" title="Flickr: Galerie de Thomas Hawk" href="https://www.flickr.com/photos/thomashawk">Thomas Hawk</a>
                                </div>
                            </div>
                        </c:when>

                        <%-- ===== Contrast not OK ========================================================================================= --%>
                        <%-- Invalid contrast: present solutions --%>
                        <c:otherwise>
                            <div class="row">
                                <div class="result col-lg-12">
                                    <h2> <fmt:message key="form.contrastOld"/></h2>
                                </div>
                                <div id="old-contrast" class="result col-lg-12">
                                    <table id="initial-contrast" class="table">
                                        <caption class="sr-only"><fmt:message key="form.initialContrastCaption"/></caption>
                                        <tr>
                                            <th scope="col" class="col01"><fmt:message key="form.contrastSolutionForeground"/></th>
                                            <th scope="col" class="col02"><fmt:message key="form.contrastSolutionBackground"/></th>
                                            <th scope="col" class="col04"><fmt:message key="form.contrastSolutionSample"/></th>
                                            <th scope="col" class="col03"><fmt:message key="form.contrastSolutionRatio"/></th>
                                            <th scope="col" class="col05"><fmt:message key="form.contrastSolutionDistance"/></th>
                                        </tr>
                                        <tr>
                                            <td class="col01">
                                                <div class="cercle" style="background-color:${colorModel.foreground}"></div>
                                                <ul class="color-codes">
                                                    <li class="color-value-hsl">${foregroundHSLColor}</li>
                                                    <li class="color-value-rgb">${foregroundColor}</li>
                                                    <li class="color-value-hexa">${foregroundHEX}</li>
                                                </ul>
                                            </td>
                                            <td class="col02">
                                                <div class="cercle" style="background-color:${colorModel.background}"></div>
                                                <ul class="color-codes">
                                                    <li class="color-value-hsl">${backgroundHSLColor}</li>
                                                    <li class="color-value-rgb">${backgroundColor}</li>
                                                    <li class="color-value-hexa">${backgroundHEX}</li>
                                                </ul>
                                            </td>
                                            <td  class="text-sample" style="color:${colorModel.foreground};background-color:${colorModel.background}">
                                                <p style="font-size:20px;">
                                                    <fmt:message key="form.sampleTitle"/>
                                                    <span style="font-weight:bold;"><fmt:message key="form.sampleTitleBold"/></span>
                                                </p>
                                                <p>
                                                    <fmt:message key="form.sampleText"/>
                                                    <span style="font-weight:bold;"><fmt:message key="form.sampleTextBold"/></span>
                                                    <fmt:message key="form.sampleText2"/>
                                                </p>
                                            </td>
                                            <td class="col03">
                                                ${oldContrast}
                                            </td>
                                            <td class="col05">
                                                ${oldDistance}
                                            </td>
                                        </tr>
                                    </table>
                                </div><!-- /col-lg-12 -->
                                <div class ="col-lg-12">
                                    <c:choose>
                                        <c:when test="${colorResult.numberOfSuggestedColors == 0}">
                                            <div class="h2-on-empty-result">
                                            </c:when>
                                            <c:otherwise>
                                                <div>
                                                </c:otherwise>
                                            </c:choose>
                                            <h2> <fmt:message key="form.contrastNew"/> : <fmt:message key="form.resultNumber"><fmt:param value="${resultNumber}"/></fmt:message>
                                                <span id="tested-color">(<fmt:formatNumber value="${colorResult.numberOfTestedColors}"/> <fmt:message key="form.testedColors"/>)</span></h2>
                                        </div>
                                        <c:if test="${colorResult.numberOfSuggestedColors > 0}">
                                            <table id="contrast-solution" class="table tablesorter">
                                                <caption id="theCaption" class="sr-only"><fmt:message key="form.contrastSolutionCaption"/></caption>
                                                <thead>
                                                    <tr>
                                                        <th scope="col" class="col01"><fmt:message key="form.contrastSolutionForeground"/></th>
                                                        <th scope="col" class="col02"><fmt:message key="form.contrastSolutionBackground"/></th>
                                                        <th scope="col" class="col04"><fmt:message key="form.contrastSolutionSample"/></th>
                                                        <th scope="col" class="col03"><fmt:message key="form.contrastSolutionRatio"/></th>
                                                        <th scope="col" class="col05"><abbr title="<fmt:message key="form.contrastSolutionDistanceEx"/>">
                                                                <fmt:message key="form.contrastSolutionDistance"/></abbr></th>
                                                    </tr>
                                                </thead>
                                                <c:if test="${colorModel.isBackgroundTested}">
                                                    <c:forEach var="result" items="${colorResult.suggestedColors}">
                                                        <tr>
                                                            <td class="col01">
                                                                <div class="cercle" style="background-color:rgb(${result.comparisonColor.red}, ${result.comparisonColor.green}, ${result.comparisonColor.blue})"></div>
                                                                <ul class="color-codes">
                                                                    <li class="color-value-hsl">${result.hslColorComp}</li>
                                                                    <li class="color-value-rgb">rgb(${result.comparisonColor.red}, ${result.comparisonColor.green}, ${result.comparisonColor.blue})</li>
                                                                    <li class="color-value-hexa">${result.hexaColorComp}</li>
                                                                </ul>
                                                            </td>
                                                            <td class="col02">
                                                                <div class="cercle" style="background-color:rgb(${result.color.red}, ${result.color.green}, ${result.color.blue})"></div>
                                                                <ul class="color-codes">
                                                                    <li class="color-value-hsl">${result.hslColor}</li>
                                                                    <li class="color-value-rgb">rgb(${result.color.red}, ${result.color.green}, ${result.color.blue})</li>
                                                                    <li class="color-value-hexa">${result.hexaColor}</li>
                                                                </ul>
                                                            </td>
                                                            <td  class="text-sample" style="
                                                                 color:rgb(${result.comparisonColor.red}, ${result.comparisonColor.green}, ${result.comparisonColor.blue});
                                                                 background-color:rgb(${result.color.red}, ${result.color.green}, ${result.color.blue})">

                                                                <p style="font-size:20px;">
                                                                    <fmt:message key="form.sampleTitle"/>
                                                                    <span style="font-weight:bold;"><fmt:message key="form.sampleTitleBold"/></span>
                                                                </p>
                                                                <p>
                                                                    <fmt:message key="form.sampleText"/>
                                                                    <span style="font-weight:bold;"><fmt:message key="form.sampleTextBold"/></span>
                                                                    <fmt:message key="form.sampleText2"/>
                                                                </p> 
                                                            </td>
                                                            <td class="col03">
                                                                ${result.contrast}
                                                            </td>
                                                            <td class="col05">
                                                                ${result.distance}
                                                            </td>                                                    
                                                        </tr>
                                                    </c:forEach>    
                                                </c:if>
                                                <c:if test="${!colorModel.isBackgroundTested}">
                                                    <c:forEach var="result" items="${colorResult.suggestedColors}"> 
                                                        <tr>
                                                            <td class="col01">
                                                                <div class="cercle" style="background-color:rgb(${result.color.red}, ${result.color.green}, ${result.color.blue})"></div>
                                                                <ul class="color-codes">
                                                                    <li class="color-value-hsl">${result.hslColor}</li>
                                                                    <li class="color-value-rgb">rgb(${result.color.red}, ${result.color.green}, ${result.color.blue})</li>
                                                                    <li class="color-value-hexa">${result.hexaColor}</li>
                                                                </ul>
                                                            </td>
                                                            <td class="col02">
                                                                <div class="cercle" style="background-color:rgb(${result.comparisonColor.red}, ${result.comparisonColor.green}, ${result.comparisonColor.blue})"></div>
                                                                <ul class="color-codes">
                                                                    <li class="color-value-hsl">${result.hslColorComp}</li>
                                                                    <li class="color-value-rgb">rgb(${result.comparisonColor.red}, ${result.comparisonColor.green}, ${result.comparisonColor.blue})</li>
                                                                    <li class="color-value-hexa">${result.hexaColorComp}</li>
                                                                </ul>
                                                            </td>
                                                            <td  class="text-sample" style="
                                                                 color:rgb(${result.color.red}, ${result.color.green}, ${result.color.blue});
                                                                 background-color:rgb(${result.comparisonColor.red}, ${result.comparisonColor.green}, ${result.comparisonColor.blue})">
                                                                <p style="font-size:20px;">
                                                                    <fmt:message key="form.sampleTitle"/>
                                                                    <span style="font-weight:bold;"> <fmt:message key="form.sampleTitleBold"/> </span>
                                                                </p>
                                                                <p>
                                                                    <fmt:message key="form.sampleText"/>
                                                                    <span style="font-weight:bold;"> <fmt:message key="form.sampleTextBold"/> </span>
                                                                    <fmt:message key="form.sampleText2"/>
                                                                </p> 
                                                            </td>
                                                            <td class="col03">
                                                                ${result.contrast}
                                                            </td>
                                                            <td class="col05">
                                                                ${result.distance}
                                                            </td>      
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                            </table>
                                        </c:if>
                                        <div id="notSatisfied">
                                            <fmt:message key="form.notSatisfied" />
                                        </div>
                                        <c:if test="${colorResult.numberOfSuggestedColors > 0}">
                                            <c:set var="retryUrl">
                                                <c:url value="result.html?foreground=${colorModel.foreground}&amp;background=${colorModel.background}&amp;algo=${otherAlgo}&amp;ratio=${colorModel.ratio}&amp;isBackgroundTested=${colorModel.isBackgroundTested}"></c:url>
                                            </c:set>
                                            <div class="noResult">
                                                <c:if test="${algo == 'HSV'}">
                                                    <a href="${fn:replace(retryUrl, '#', '%23')}"><fmt:message key="form.tryRgb"/></a>
                                                </c:if>
                                                <c:if test="${algo == 'Rgb'}">
                                                    <a href="${fn:replace(retryUrl, '#', '%23')}"><fmt:message key="form.tryHsv"/></a>
                                                </c:if>
                                            </div>
                                        </c:if>
                                        <c:if test="${colorResult.numberOfSuggestedColors == 0}">
                                            <c:set var="retryUrl">
                                                <c:url value="result.html?foreground=${colorModel.foreground}&amp;background=${colorModel.background}&amp;algo=${algo}&amp;ratio=${colorModel.ratio}&amp;isBackgroundTested=${!colorModel.isBackgroundTested}"></c:url>
                                            </c:set>
                                            <div class="noResult">
                                                <fmt:message key="form.anyResult"/> <a href="${fn:replace(retryUrl, '#', '%23')}"><fmt:message key="form.changeComponent"/>
                                                    <c:if test="${colorModel.isBackgroundTested}"><strong><fmt:message key="form.oppositeComponentBackground"/></strong></a>.</c:if>
                                                <c:if test="${!colorModel.isBackgroundTested}"><strong><fmt:message key="form.oppositeComponentForeground"/></strong></a>.</c:if>
                                                </div>
                                        </c:if>
                                    </div><!-- /col-lg-12 -->
                                </div><!-- /row -->
                            </c:otherwise>
                        </c:choose>        
                    </c:if>

                <%-- ===== USER HELP ========================================================================================= --%>
                <div class="help"> <%-- only on HomePage --%>
                    <c:if test="${empty colorResult}">
                        <fmt:message key="home.noResultTxt"/>
                    </c:if>
                </div>
            </div>  <!-- class="container' -->


            <%-- ===== FOOTER ========================================================================================= --%>
            <%@include file='/WEB-INF/template/footer.jspf' %>

            <!-- Javascript - Webapp -->
            <script src="<c:url value="Js/_contrast-finder.all.min.js?v=${appVersion}"/>"></script>
               <!-- <script src="<c:url value="Js/10-jquery.min.js?v=${appVersion}"/>"></script>
                    <c:if test="${colorResult.numberOfSuggestedColors > 0}">
                        <script src="<c:url value="Js/20-jquery.tablesorter.min.js?v=${appVersion}"/>"></script>
                        <script src="<c:url value="Js/25-accessible-min.js?v=${appVersion}"/>"></script>
                    </c:if>
                    <script src="<c:url value="Js/30-bootstrap.min.js?v=${appVersion}"/>"></script>
                    <script src="<c:url value="Js/35-affix.js?v=${appVersion}"/>"></script>
                    <script src="<c:url value="Js/36-sample.color.js?v=${appVersion}"/>"></script>
               -->

            <!-- Javascript - Web analytics -->
            <c:set var="piwikSiteId"     value="${piwikKey}"/>
            <c:set var="piwikServerURL"  value="${piwikServer}"/>
            <c:if test="${not empty piwikSiteId and not empty piwikServerURL}">
                <!-- Piwik code-->
                <script type="text/javascript">
                    var _paq = _paq || [];
                    _paq.push(["setDomains", ["*.app.contrast-finder.org","*.app.contrast-finder.org"]]);
                    _paq.push(['trackPageView']);
                    _paq.push(['enableLinkTracking']);
                    function loadPiwikAfterOnload(){
                        var u='${piwikServerURL}';
                        _paq.push(['setTrackerUrl', u+'piwik.php']);
                        _paq.push(['setSiteId', '${piwikSiteId}']);
                        var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
                        g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
                    }
                    if (window.addEventListener){ window.addEventListener("load", loadPiwikAfterOnload, false); }
                    else if (window.attachEvent){ window.attachEvent("onload", loadPiwikAfterOnload);           }
                    else                        { window.onload = loadPiwikAfterOnload();                       }
                </script><noscript><img src="${piwikServerURL}piwik.php?idsite=${piwikSiteId}" style="border:0;" alt="" /></noscript>
                <!-- End Piwik code -->
            </c:if>
        </body>
    </html>
</compress:html>
