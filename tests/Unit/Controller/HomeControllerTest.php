<?php declare(strict_types=1);
/**
 * @author Marco Spengler <MaSpeng@outlook.de>
 */

namespace MaSpeng\PhpCiSandbox\Tests\Unit\Controller;

use MaSpeng\PhpCiSandbox\Controller\HomeController;
use PHPUnit\Framework\TestCase;
use Symfony\Component\HttpFoundation\JsonResponse;

/**
 * @covers \MaSpeng\PhpCiSandbox\Controller\HomeController
 */
class HomeControllerTest extends TestCase
{
    public function testIndexAction(): void
    {
        $controller = $this->createPartialMock(
            HomeController::class,
            [
                'json',
            ]
        );

        $controller->expects(static::once())
            ->method('json')
            ->with(
                [
                    'message' => 'Welcome to your new controller!',
                ]
            )
            ->willReturn(
                $this->createMock(JsonResponse::class)
            );

        $controller->index();
    }
}
