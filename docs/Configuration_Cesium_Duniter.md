### Configuration pour Cesium

---

1. Telecharger [Cesium](https://cesium.app/fr/telechargement)  (Version recommandée: **FireFox**)
2. Créer un compte -> Member account -> Garder bien vôtres identifier et le mot de passe, vous en avez besoin pour login césium et Duniter aussi
3. Cliquer Settings, et puis changer Duniter peer address pour  g1-test.duniter.org (La verte ligne)
4. Vous pouvez demander des certifications en forum pour être un membre



### Configuration pour [Duniter](https://duniter.org/en/wiki/duniter/install/#server-version) 

---

#### Desktop version

1. Télécharger [Duniter](https://duniter.org/en/wiki/duniter/install/#server-version) et synchronizer un noeud aléatoire
2. Paramètres -> CRYPTO -> CHANGE KEYRINGS, et mettre le compte de Césium que vous avez créé dans le keyring. Une fois que vous faites ça, vous avez votre propre nœud, sinon il est un nœud aléatoire

---

#### Server Version

Après l'installation de duniter, aller au terminal, pour synchronizer un noeud, faire

```terminal
duniter sync gtest.duniter.org
```

Pour démarrer le server Duniter avec des logs au terminal, faire

```terminal
duniter direct_webrestart 
```

Aller à l'address localhost:9220 pour regarder le noeud en site web, ensuite vous pouvez faire CHANGE KEYRINGS pour avoir votre propre nœud. Vous pouvez aussi trouver votre keyrings en home/.config/duniter/duniter_default/keyring.yml, vous pouvez changer directement keyrings dans ce fichier
