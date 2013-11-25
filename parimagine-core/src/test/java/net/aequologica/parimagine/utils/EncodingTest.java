package net.aequologica.parimagine.utils;

import org.junit.Test;

import com.google.common.base.Charsets;

public class EncodingTest {

    @Test
    public void voidtest() {
    }

	// @Test
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
