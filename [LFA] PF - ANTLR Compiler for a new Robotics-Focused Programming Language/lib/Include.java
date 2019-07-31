package lib;

import java.util.ArrayList;

public class Include {
	private final ArrayList<String> globalHeaders;
	private final ArrayList<String> localHeaders;

	public Include() {
		this.globalHeaders = new ArrayList<>();
		this.localHeaders = new ArrayList<>();
	}

	public ArrayList<String> getGlobalHeaders()		{ return new ArrayList<String>(globalHeaders); }		// returns copy of globalHeaders
	public ArrayList<String> getLocalHeaders() 		{ return new ArrayList<String>(localHeaders); }			// returns copy of localHeaders

	public boolean addGlobalHeader(String header) {
		if (header == null) throw new IllegalArgumentException("Argument \'String header\' is null.");
		if (!header.matches("(.*).h")) throw new IllegalArgumentException("Given header is not of type \'.h\'.");
		return globalHeaders.add(header);
	}

	public boolean addLocalHeader(String header) {
		if (header == null) throw new IllegalArgumentException("Argument \'String header\' is null.");
		if (!header.matches("(.*).h")) throw new IllegalArgumentException("Given header is not of type \'.h\'.");		
		return localHeaders.add(header);
	}

	public boolean removeGlobalHeader(String header) {
		if (header == null) throw new IllegalArgumentException("Argument \'String header\' is null.");
		if (!header.matches("(.*).h")) throw new IllegalArgumentException("Given header is not of type \'.h\'.");
		return globalHeaders.remove(header);
	}

	public boolean removeLocalHeader(String header) {
		if (header == null) throw new IllegalArgumentException("Argument \'String header\' is null.");
		if (!header.matches("(.*).h")) throw new IllegalArgumentException("Given header is not of type \'.h\'.");
		return localHeaders.remove(header);
	}

	public boolean hasGlobalHeader(String header) {
		if (header == null) throw new IllegalArgumentException("Argument \'String header\' is null.");
		if (!header.matches("(.*).h")) throw new IllegalArgumentException("Given header is not of type \'.h\'.");

		String[] ext = header.split(".");
		try {
			String dummy = ext[1];
		}
		catch(ArrayIndexOutOfBoundsException | NullPointerException e) {
			throw new IllegalArgumentException("Argument \'String header\' is invalid.");
		}

		return localHeaders.contains(header);
	}

	public boolean hasLocalHeader(String header) {
		if (header == null) throw new IllegalArgumentException("Argument \'String header\' is null.");
		if (!header.matches("(.*).h")) throw new IllegalArgumentException("Given header is not of type \'.h\'.");

		String[] ext = header.split(".");
		try {
			String dummy = ext[1];
		}
		catch(ArrayIndexOutOfBoundsException | NullPointerException e) {
			throw new IllegalArgumentException("Argument \'String header\' is invalid.");
		}

		return localHeaders.contains(header);
	}

	public boolean equals(Include i) {
		if (i == null) throw new IllegalArgumentException("Argument \'Include i\' is null.");

		return (this.globalHeaders.equals(i.getGlobalHeaders()) && this.localHeaders.equals(i.getLocalHeaders()));
	}
}