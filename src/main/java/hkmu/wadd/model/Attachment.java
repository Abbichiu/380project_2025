package hkmu.wadd.model;

public class Attachment {
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    private String id;

    public String getName() {
        return name;
    }

    public String getMimeContentType() {
        return mimeContentType;
    }

    public byte[] getContents() {
        return contents;
    }

    public void setContents(byte[] contents) {
        this.contents = contents;
    }

    public void setMimeContentType(String mimeContentType) {
        this.mimeContentType = mimeContentType;
    }

    public void setName(String name) {
        this.name = name;
    }

    private String name;
    private String mimeContentType;
    private byte[] contents;
}

