'''round robin tournament matches generator'''


# demo code
teams = ["Team1", "Team2", "Team3", "Team4", "Team5"]


def fixtures(teams):
    if len(teams) % 2:
        teams.append('Day off')  # if team number is odd - use 'day off' as fake team     

    rotation = list(teams)       # copy the list

    fixtures = []
    for i in range(0, len(teams)-1):
        fixtures.append(rotation)
        rotation = [rotation[0]] + [rotation[-1]] + rotation[1:-1]

    return fixtures

fixtures1 = fixtures(teams)

print('fixtures1')
print(fixtures1)

fixtures2 = []

for turn in fixtures1:
    newTurn = []
    while len(turn) > 0:
        newTurn.append([turn.pop(0),turn.pop(0)])
    fixtures2.append(newTurn)

print('fixtures2')
print(fixtures2)

def printout(team):
    for turn in fixtures2:
        for match in turn:
            if team == match[0]:
                print(match)
                break
            if team == match[1]:
                print(match[::-1])
                break

printout('Team2')
                
