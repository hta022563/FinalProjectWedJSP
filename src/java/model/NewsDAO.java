package model;

import java.util.List;
import javax.persistence.EntityManager;
import utils.JPAUtil;

public class NewsDAO {

    public List<NewsDTO> getAllNews() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT n FROM NewsDTO n ORDER BY n.publishDate DESC";
            return em.createQuery(jpql, NewsDTO.class).getResultList();
        } finally {
            em.close();
        }
    }

    public NewsDTO getNewsByID(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(NewsDTO.class, id);
        } finally {
            em.close();
        }
    }

    public boolean addNews(NewsDTO news) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(news);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }

    public boolean updateNews(NewsDTO news) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(news);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }

    public boolean deleteNews(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            NewsDTO news = em.find(NewsDTO.class, id);
            if (news != null) {
                em.remove(news);
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return false;
        } finally {
            em.close();
        }
    }
}
