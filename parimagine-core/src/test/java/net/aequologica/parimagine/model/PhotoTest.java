package net.aequologica.parimagine.model;

import static org.junit.Assert.assertFalse;

import org.junit.Test;

public class PhotoTest {

	@Test
	public void testCompareTo() {
		Address a = new Address();
		a.setDistrict(0);
		Photo p0 = new Photo();
		p0.setImage("photos-presse/saisons/p337.jpg");
		p0.setAddress(a);
		Photo p1 = new Photo();
		p1.setImage("arrondissements/paris-1/426.jpg");
		p1.setAddress(a);

		assertFalse(0 == p0.compareTo(p1));

	}

}
