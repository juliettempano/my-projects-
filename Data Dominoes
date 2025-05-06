import pygame
import random

# Initialize pygame
pygame.init()

# Screen setup
WIDTH, HEIGHT = 900, 600
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Data Dominoes - Pygame")

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
BLUE = (50, 130, 200)
GREEN = (34, 139, 34)

# Font
font = pygame.font.Font(None, 32)

# Domino setup (one word or phrase each side)
concepts = ["Paper Forms", "Messy Database", "Centralized Database"]
meanings = ["Not Sustainable", "Messy Data", "Comprehensive Data Analysis"]

# Match key
answer_key = {
    "Paper Forms": "Not Sustainable",
    "Messy Database": "Messy Data",
    "Centralized Database": "Comprehensive Data Analysis"
}

# Explanations
explanations = {
    "Paper Forms": "Paper forms are not sustainable due to waste and inefficiency.",
    "Messy Database": "Messy data causes delays and analysis errors.",
    "Centralized Database": "Centralized systems improve analysis by unifying data."
}

# Shuffle and pair
random.shuffle(concepts)
random.shuffle(meanings)

# Tile and hand setup
TILE_WIDTH, TILE_HEIGHT = 300, 80
player_hand = concepts
board_tiles = meanings

selected_concept = None
feedback_message = ""
explanation_text = ""

# Draw function
def draw_tile(text, x, y, selected=False):
    pygame.draw.rect(screen, WHITE, (x, y, TILE_WIDTH, TILE_HEIGHT))
    pygame.draw.rect(screen, BLUE if selected else BLACK, (x, y, TILE_WIDTH, TILE_HEIGHT), 3)
    rendered = font.render(text, True, BLACK)
    screen.blit(rendered, (x + 10, y + 25))

# Main loop
running = True
while running:
    screen.fill(GREEN)

    # Draw concept tiles (player hand)
    for i, concept in enumerate(player_hand):
        x = 50
        y = 50 + i * (TILE_HEIGHT + 20)
        draw_tile(concept, x, y, selected_concept == i)

    # Draw meaning tiles (on the right)
    for i, meaning in enumerate(board_tiles):
        x = WIDTH - TILE_WIDTH - 50
        y = 50 + i * (TILE_HEIGHT + 20)
        draw_tile(meaning, x, y)

    # Show feedback
    if feedback_message:
        text = font.render(feedback_message, True, WHITE)
        screen.blit(text, (WIDTH // 2 - text.get_width() // 2, HEIGHT - 100))

    # Show explanation
    if explanation_text:
        explain = font.render(explanation_text, True, WHITE)
        screen.blit(explain, (WIDTH // 2 - explain.get_width() // 2, HEIGHT - 60))

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

        elif event.type == pygame.MOUSEBUTTONDOWN:
            mx, my = pygame.mouse.get_pos()# Click on concept (left side)
            for i, concept in enumerate(player_hand):
                x = 50
                y = 50 + i * (TILE_HEIGHT + 20)
                if x <= mx <= x + TILE_WIDTH and y <= my <= y + TILE_HEIGHT:
                    selected_concept = i
                    feedback_message = ""
                    explanation_text = ""

            # Click on meaning (right side)
            for i, meaning in enumerate(board_tiles):
                x = WIDTH - TILE_WIDTH - 50
                y = 50 + i * (TILE_HEIGHT + 20)
                if x <= mx <= x + TILE_WIDTH and y <= my <= y + TILE_HEIGHT and selected_concept is not None:
                    selected_word = player_hand[selected_concept]
                    if answer_key.get(selected_word) == meaning:
                        feedback_message = "✅ Correct match!"
                        explanation_text = explanations.get(selected_word, "")
                        player_hand.pop(selected_concept)
                        board_tiles.pop(i)
                    else:
                        feedback_message = "❌ Try again!"
                        explanation_text = ""
                    selected_concept = None

    pygame.display.flip()

pygame.quit()

