package model;

import java.util.Date;
import javax.persistence.*;

@Entity
@Table(name = "News")
public class NewsDTO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "NewsID")
    private int newsID;

    @Column(name = "Title")
    private String title;

    @Column(name = "Content")
    private String content;

    @Column(name = "Thumbnail")
    private String thumbnail;

    @Column(name = "PublishDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date publishDate;

    @Column(name = "ExternalLink")
    private String externalLink;

    public NewsDTO() {
    }

    public NewsDTO(int newsID, String title, String content, String thumbnail, Date publishDate, String externalLink) {
        this.newsID = newsID;
        this.title = title;
        this.content = content;
        this.thumbnail = thumbnail;
        this.publishDate = publishDate;
        this.externalLink = externalLink;
    }

    // --- GETTER & SETTER ---
    public int getNewsID() {
        return newsID;
    }

    public void setNewsID(int newsID) {
        this.newsID = newsID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public String getExternalLink() {
        return externalLink;
    }

    public void setExternalLink(String externalLink) {
        this.externalLink = externalLink;
    }
}
