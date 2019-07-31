package lib;

public class Header {
    private static String header;

    public static void setHeader(String header) {
        Header.header = header;
    }

    public static String getHeader(){
        return header;
    }
}
