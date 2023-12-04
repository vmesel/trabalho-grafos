
// Cria jogadores
LOAD CSV WITH HEADERS FROM 'file:///nfl.csv' AS row
CREATE (:Player {name: row.Player, position: row.Pos, height: row.HT, weight: row.WT, age: row.Age, experience: row.Exp})

// Cria times
LOAD CSV WITH HEADERS FROM 'file:///nfl.csv' AS row
WITH DISTINCT row.Team AS team
CREATE (:Team {name: team})

// Cria faculdades
LOAD CSV WITH HEADERS FROM 'file:///nfl.csv' AS row
WITH DISTINCT row.College AS college
CREATE (:College {name: college})

// Relaciona jogador com time
LOAD CSV WITH HEADERS FROM 'file:///nfl.csv' AS row
MATCH (p:Player {name: row.Player})
MATCH (t:Team {name: row.Team})
MERGE (p)-[:PLAYS_FOR]->(t)

// Associa jogador com faculdade
LOAD CSV WITH HEADERS FROM 'file:///nfl.csv' AS row
MATCH (p:Player {name: row.Player})
MATCH (c:College {name: row.College})
MERGE (p)-[:GRADUATED_FROM]->(c)
