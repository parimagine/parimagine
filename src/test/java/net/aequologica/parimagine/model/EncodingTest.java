package net.aequologica.parimagine.model;

import org.junit.Test;

import com.google.common.base.Charsets;

public class EncodingTest {

	/**
    <!-- Charset.defaultCharset(): "<%= java.nio.charset.Charset.defaultCharset() %>" -->
    <!-- request.getParameter("search"): "<%= request.getParameter("search") %>" -->
    <!-- request.getParameter("search").getBytes(java.nio.charset.Charset.forName("ISO-8859-1")): "<%= new String(request.getParameter("search").getBytes(java.nio.charset.Charset.forName("ISO-8859-1"))) %>" -->
    <!-- request.getParameter("search").getBytes(java.nio.charset.Charset.forName("UTF-8")): "<%= new String(request.getParameter("search").getBytes(java.nio.charset.Charset.forName("UTF-8"))) %>" -->
    <!-- request.getParameter("search").getBytes(java.nio.charset.Charset.defaultCharset()): "<%= new String(request.getParameter("search").getBytes(java.nio.charset.Charset.defaultCharset())) %>" -->
    <!-- new String(request.getParameter("search").getBytes("ISO-8859-1"), "UTF-8"): "<%= new String(request.getParameter("search").getBytes("ISO-8859-1"), "UTF-8") %>" -->
	 */
	@Test
	public void test() {
		byte[] bytes = new byte[]{(byte) 0xC3, (byte) 0xa9};
		String s = new String(bytes, Charsets.ISO_8859_1);
		String s2 = new String(s.getBytes(Charsets.ISO_8859_1));
		String s3 = new String(bytes, Charsets.UTF_8);
		System.out.println(s);
		System.out.println(s2);
		System.out.println(s3);
		
	}

}
