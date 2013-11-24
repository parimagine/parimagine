package net.aequologica.parimagine.model;

public class GeoData {
	
	private LatLng lat_lng;
	private Pov pov;
	private int zoom;
	
	public LatLng getLatLng() {
		return lat_lng;
	}

	public void setLatLng(LatLng lat_lng) {
		this.lat_lng = lat_lng;
	}

	public Pov getPov() {
		return pov;
	}

	public void setPov(Pov pov) {
		this.pov = pov;
	}

	public int getZoom() {
		return zoom;
	}

	public void setZoom(int zoom) {
		this.zoom = zoom;
	}

	public static class LatLng {
		double lat;
		double lng;
		public double getLat() {
			return lat;
		}
		public void setLat(double lat) {
			this.lat = lat;
		}
		public double getLng() {
			return lng;
		}
		public void setLng(double lng) {
			this.lng = lng;
		}
	}

	public static class Pov {
		double heading;
		double pitch;
		public double getHeading() {
			return heading;
		}
		public void setHeading(double heading) {
			this.heading = heading;
		}
		public double getPitch() {
			return pitch;
		}
		public void setPitch(double pitch) {
			this.pitch = pitch;
		}
	}
}
