<?php declare(strict_types=1);
/**
 * This file is part of the gitlab-php-ci-sandbox project.
 *
 * @author Marco Spengler <MaSpeng@outlook.de>
 */

namespace App\Controller;

use PHPUnit\Framework\TestCase;
use Symfony\Component\HttpFoundation\JsonResponse;

/**
 * Home controller test class
 *
 * @package App\Controller
 *
 * @covers  \App\Controller\HomeController
 */
class HomeControllerTest extends TestCase
{
    /**
     * Test index action
     *
     * @return void
     */
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
