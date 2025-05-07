package model;

import java.time.LocalDateTime;

public class Ticket {
    private String id;                // uuid PK
    private String subject;           // maps to tickets.subject
    private String description;       // maps to tickets.description
    private String priority;          // normal | urgent
    private String status;            // open | in_progress | closed
    private LocalDateTime createdAt;  // tickets.created_at
    private LocalDateTime updatedAt;  // tickets.updated_at

    public Ticket() {}

    public Ticket(String id,
                  String subject,
                  String description,
                  String priority,
                  String status,
                  LocalDateTime createdAt,
                  LocalDateTime updatedAt) {
        this.id = id;
        this.subject = subject;
        this.description = description;
        this.priority = priority;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // ─── Getters & Setters ────────────────────────────────────

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    @Override
    public String toString() {
        return "Ticket{" +
               "id='" + id + '\'' +
               ", subject='" + subject + '\'' +
               ", description='" + description + '\'' +
               ", priority='" + priority + '\'' +
               ", status='" + status + '\'' +
               ", createdAt=" + createdAt +
               ", updatedAt=" + updatedAt +
               '}';
    }
}
