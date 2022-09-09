package test;

public class XssUtil {

	  public static String cleanXSS(String value) {
	    String returnVal = value;
	    returnVal = returnVal.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	    returnVal = returnVal.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
	    returnVal = returnVal.replaceAll("'", "&#39;");
	    returnVal = returnVal.replaceAll("eval\\((.*)\\)", "");
	    returnVal = returnVal.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
	    returnVal = returnVal.replaceAll("script", "");
	    returnVal = returnVal.replaceAll("iframe", "");
	    returnVal = returnVal.replaceAll("embed", "");
	    returnVal = returnVal.replaceAll("/", "&#47");
	    return returnVal;
	  }
}