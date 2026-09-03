#include <stdint.h>

#define RCC_AHB1ENR   (*((volatile uint32_t *)0x40023830))
#define GPIOC_MODER   (*((volatile uint32_t *)0x40020800))
#define GPIOC_ODR     (*((volatile uint32_t *)0x40020814))
#define RCC_GPIOC_EN  (1 << 2)

void delay(volatile uint32_t count) {
    while (count--);
}

int main(void) {
    RCC_AHB1ENR |= RCC_GPIOC_EN;
    delay(1000);
    GPIOC_MODER &= ~(3U << 26);
    GPIOC_MODER |=  (1U << 26);

    while (1) {
        GPIOC_ODR ^= (1 << 13);
        delay(50000000);
    }

    return 0;
}