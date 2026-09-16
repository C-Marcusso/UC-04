PRAGMA foreign_keys = ON;

-- CRIAÇÃO DE TABLEAS

CREATE TABLE IF NOT EXISTS Clientes
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cpf TEXT NOT NULL UNIQUE,
    telefone TEXT
);

CREATE TABLE IF NOT EXISTS Veiculos
(
    id INTEGER PRIMARY KEY  AUTOINCREMENT,
    cliente_id INTERGER NOT NULL,
    placa TEXT NOT NULL UNIQUE,
    modelo TEXT NOT NULL,
    cor TEXT,
    FOREIGN KEY (cliente_id) REFERENCES Clientes (id) ON DELETE CASCADE
);

/* Ativiade:
- Adicione as tabelas:
    - 'Vagas'(localizacao, tipo)
    - 'RegistrosEstacionamento' (veiculo, vaga, data_hora_entrada/saida, valor_toal)*/
CREATE TABLE IF NOT EXISTS Vagas
(
    id INTEGER PRIMARY KEY AUTOINCREMENT
    localizacao TEXT NOT NULL UNIQUE,
    tipo TEXT NOT NULL
);
-- Talvez usar um check para verificar o tipo da vaga

CREATE TABLE IF NOT EXISTS Registro_Estacionamento
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    veiculo_id INTEGER NOT NULL,
    vaga_id TEXT NOT NULL,
    data_hora_entrada TEXT NOT NULL TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_hora_saida TEXT,
    valor_total REAL DEFAULT 0.0
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos (id) ON DELETE RESTRICT,
    FOREIGN KEY (vaga_id) REFERENCES Vagas (id) ON DELETE RESTRICT
);
-- INSERÇÃO DE DADOS

INSERT INTO Clientes (nome, cpf, telefone) VALUES
('Fulano Cicrano', '11111111111', '11911111111'),
('Ana Carolina', '22222222222', '11922222222'),
('Maria Eduarda', '33333333333', '11933333333'),
('Carlos Eduardo', '44444444444', '11944444444');

INSERT INTO Veiculos (cliente_id, placa, modelo, cor) VALUES
(1, 'ABC1D23', 'Chevrolet Onix', 'Azul'),
(2, 'EFG4H56', 'Hyundai HB20', 'Cinza'),
(2, 'IJK7L89', 'Jeep Compass', 'Verde'),
(3, 'MNO0P12', 'Toyota Corolla Cross', 'Preto'),
(3, 'QRS3T45', 'Porsche Carrera', 'Vermelho'),
(3, 'UVW6X78', 'BMW M3', 'Roxo'),
(4, 'YZA9B01', 'BYD Dolphin', 'Branco');

-- CONSULTA DE DADOS

SELECT * FROM Clientes;
SELECT * FROM Veiculos;

SELECT Vagas.id, Vagas.localizacao, Vagas.tipo
FROM RegistrosEstacionamento
INNER JOIN Vagas ON RegistrosEstacionamento.vaga_id = Vagas.id
WHERE RegistrosEstacionamento.data_hora_saida IS NULL;





/* Ativiade:
- Cadastre 4 vagas e 3 registros de estadia (um sem data de saída)
- Escreva as consultas:
    - Identificar quais vagas estão ocupadas no momento
    - Listar vagas que estão livres

SELECT Pedidos.id, Pizzas.sabor, Pedido_Itens.quantidade, Pedido_Itens.valor_unitario
FROM Pedidos
INNER JOIN Pedido_Itens ON Pedido_Itens.pedido_id = Pedidos.id
INNER JOIN Pizzas ON Pedido_Itens.pizza_id = Pizzas.id;

Ativiade:
- Adicione as tabelas:
    - 'Vagas'(localizacao, tipo)
    - 'RegistrosEstacionamento' (veiculo, vaga, data_hora_entrada/saida, valor_toal)
- Cadastre 4 vagas e 3 registros de estadia (um sem data de saída)
- Escreva as consultas:
    - Identificar quais vagas estão ocupadas no momento
    - Listar vagas que estão livres */