-- Creazione del database
CREATE DATABASE PalestraDB;
USE PalestraDB;

-- Tabella per gli utenti
CREATE TABLE Utenti (
    id_utente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(15),
    ruolo ENUM('cliente', 'istruttore', 'amministratore') DEFAULT 'cliente',
    data_registrazione DATE DEFAULT CURRENT_DATE
);

-- Tabella per le attività e corsi offerti
CREATE TABLE Attivita (
    id_attivita INT AUTO_INCREMENT PRIMARY KEY,
    nome_attivita VARCHAR(100) NOT NULL,
    descrizione TEXT,
    istruttore_id INT,
    orario_inizio TIME NOT NULL,
    orario_fine TIME NOT NULL,
    giorni_settimana VARCHAR(50), -- Es. 'Lun,Mer,Ven'
    FOREIGN KEY (istruttore_id) REFERENCES Utenti(id_utente)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Tabella per le prenotazioni
CREATE TABLE Prenotazioni (
    id_prenotazione INT AUTO_INCREMENT PRIMARY KEY,
    utente_id INT NOT NULL,
    attivita_id INT NOT NULL,
    data_prenotazione DATE NOT NULL,
    stato ENUM('confermata', 'cancellata', 'in_attesa') DEFAULT 'in_attesa',
    FOREIGN KEY (utente_id) REFERENCES Utenti(id_utente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (attivita_id) REFERENCES Attivita(id_attivita)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabella per i certificati
CREATE TABLE Certificati (
    id_certificato INT AUTO_INCREMENT PRIMARY KEY,
    utente_id INT NOT NULL,
    nome_certificato VARCHAR(150) NOT NULL,
    data_rilascio DATE NOT NULL,
    data_scadenza DATE,
    file_certificato VARCHAR(255), -- Percorso al file caricato
    FOREIGN KEY (utente_id) REFERENCES Utenti(id_utente)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabella per i risultati delle gare
CREATE TABLE RisultatiGare (
    id_risultato INT AUTO_INCREMENT PRIMARY KEY,
    utente_id INT NOT NULL,
    nome_gara VARCHAR(150) NOT NULL,
    posizione INT,
    data_gara DATE NOT NULL,
    note TEXT,
    FOREIGN KEY (utente_id) REFERENCES Utenti(id_utente)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabella per gli appuntamenti
CREATE TABLE Appuntamenti (
    id_appuntamento INT AUTO_INCREMENT PRIMARY KEY,
    utente_id INT NOT NULL,
    istruttore_id INT NOT NULL,
    data_appuntamento DATE NOT NULL,
    orario_inizio TIME NOT NULL,
    orario_fine TIME NOT NULL,
    descrizione TEXT,
    stato ENUM('confermato', 'cancellato', 'in_attesa') DEFAULT 'in_attesa',
    FOREIGN KEY (utente_id) REFERENCES Utenti(id_utente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (istruttore_id) REFERENCES Utenti(id_utente)
        ON DELETE CASCADE ON UPDATE CASCADE
);
