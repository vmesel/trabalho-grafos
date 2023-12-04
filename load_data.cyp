
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

// Pega todos os jogadores que jogaram para o Houston Texans
MATCH (p:Player)-[:PLAYS_FOR]->(t:Team {name: 'Houston Texans'})
RETURN p, t

// Pega todos os jogadores que estudaram na Texas A&M
MATCH (p:Player)-[:GRADUATED_FROM]->(c:College {name: 'Texas'})
RETURN p, c

// Pega todos os jogadores que jogaram nos Houston Texans e estudaram na UCLA
MATCH (p:Player)-[:PLAYS_FOR]->(t:Team {name: 'Houston Texans'})
MATCH (p)-[:GRADUATED_FROM]->(c:College {name: 'UCLA'})
RETURN DISTINCT p, c

// Pega todos os jogadores que jogaram com Kevin Johnson
MATCH (p1:Player)-[:PLAYS_FOR]->(t:Team)<-[:PLAYS_FOR]-(p2:Player {name: 'Kevin Johnson'})
RETURN p1, p2, t

// Pega todos os jogadores com altura igual a 5'10" e que estudaram na Utah State
MATCH (p:Player {height: '5-10'})-[:GRADUATED_FROM]->(c:College {name: 'Utah State'})
RETURN p, c