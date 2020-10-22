 function computerPlay() {
  let computerSelectionNumber = Math.ceil( Math.random() * 3 )
  switch ( computerSelectionNumber ) {
    case 1:
      return "Rock"
      break
    case 2:
      return "Paper"
      break
    case 3:
      return "Scissors"
      break
  }
}

function quantifySelection(input) {
  if ( /^rock$/i.test(input) ) {
    return 1
  } else if ( /^paper$/i.test(input) ) {
    return 2
  } else if ( /^scissors$/i.test(input) ) {
    return 3
  }
}

function playRound() {
  let playerSelection = prompt( "Make your selection: Rock, paper or scissors" )
  let computerSelection = computerPlay()
  let playerSelectionNum = quantifySelection( playerSelection )
  let computerSelectionNum = quantifySelection( computerSelection )
  let result = playerSelectionNum - computerSelectionNum

  if ( result == 0 ) {
    alert( "Draw! " + playerSelection + " can't beat " + computerSelection + "!" )
  } else if ( result == 1 || result == - 2 ) {
    playerScore++
    alert( "You win! " + playerSelection + " beats " + computerSelection + "!" )
  } else if ( result == - 1 || result == 2 ) {
    computerScore++
    alert( "You lose! " + computerSelection + " beats " + playerSelection + "!" )
  }
}

function revealResult(playerScore, computerScore) {
  if ( playerScore > computerScore ) {
    alert( "Congratulations! You win!" )
  } else if (playerScore < computerScore ) {
    alert( "Wow! You just lost." )
  } else {
    alert( "Draw. What a complete waste of time" )
  }
}

let playerScore = 0
let computerScore = 0

function game() {
  for ( let i = 0; i < 5; i++ ) {
    playRound()
    alert( "Score: You " + playerScore + " - " + computerScore + " Computer" )
  }

  revealResult(playerScore, computerScore)

}

game()