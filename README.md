# Google Scholar for CSE: A research management and academic search platform

**Google Scholar for CSE** is a replica of Google Scholar that replicates its core functionalities. Developed as part of the CSE216: Database Sessional during the 4th semester.

🎥 **YouTube Demo:** [Watch the demo here](https://youtu.be/lKqckNuzQDg)

![Google Scholar for CSE Demo](./images/gscholar.png)

---

## Features

### Authentication System
- Standard authentication for **authors**, **viewers**, and **admins**.

### Viewer Functionality
- Add documents to personal library.  
- Search documents with **standard** and **advanced search** options.  
- Read document PDFs.  
- View author profiles.  
- Generate **BibTeX citations** in multiple formats.  
- Participate in discussion forums for each document: comment and reply to queries.

### Searching
- **Standard Search:** with various filters.  
- **Advanced Search:** search by exact phrases, any of the words, specific author, journal, etc.  
- **Special Search:** keyword search with TF-IDF scoring on document titles and abstracts.

### Alerts
- Create alerts for specific phrases in titles, abstracts, or from specific authors.

### Author Profile
- List of authored documents with add/remove capability.  
- Notifications for new publications and citations.  
- Citation metrics: **total citations**, **h-index**, **i10-index**, citations by year.  
- Co-authors and affiliations overview.

### Notification System
- Receive notifications for:  
  - New citations of your papers.  
  - Comments or replies in document discussion threads.  
  - New publications added by admin.

### Visualization
- **Affiliation/Institute Statistics:** top-cited researchers, yearly publications, and document stats.  
- **Researcher Statistics:** top-cited papers, yearly publications, co-author geolocation.

### Settings
- Customize search preferences (results per page, include patents, bibliography manager).  
- Control researcher profile visibility and update notifications (automatic or via email).

### Admin Module
- Add new documents by selecting from the database or creating new authors, publications, and references.  
- Fill in title, abstract, publication date, DOI, and add document to database.  
- Notify authors of newly added content via the notification system.








## [Project Home with Tree](home/README.md)


##  Design and Resources
[Google Drive Shared Folder](https://drive.google.com/drive/u/2/folders/15dWzTAfyd_mNNlgXnLJ0IK--2CooJPMz)

## References

### Oracle
- [How to create id with AUTO_INCREMENT on Oracle?](https://stackoverflow.com/questions/11296361/how-to-create-id-with-auto-increment-on-oracle)
- [Oracle Bulk Import](https://stackoverflow.com/questions/22241428/oracle-bulk-import)

### Django
- [Numeric for loop in Django templates](https://stackoverflow.com/questions/1107737/numeric-for-loop-in-django-templates)
- [Django migration issue with Oracle Database](https://stackoverflow.com/questions/62868374/django-migration-issue-with-oracle-database)


## Data Collection
PDF scraping in java is slow for data collection, currently using this python api: https://github.com/scholarly-python-package/scholarly .

Microsoft Academic Graph:
https://www.microsoft.com/en-us/research/project/microsoft-academic-graph/?from=http%3A%2F%2Fresearch.microsoft.com%2Fmag


## Software Framework:

Database: Oracle DBMS

Programming Language: Python 3

UI: Django (Web)

## Collaborators:
Shakil Ahmed     , S201705018, Undergrad, CSE, BUET

Shayekh Bin Islam, S201705009, Undergrad, CSE, BUET

Academic Adviser: [Mohammed Eunus Ali](https://sites.google.com/site/mohammedeunusali/)
