<?php
declare(strict_types = 1);
namespace Bk2k\SiteIntroduction\Tests\Acceptance\Support;

/*
 * This file is part of the TYPO3 CMS project.
 *
 * It is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License, either version 2
 * of the License, or any later version.
 *
 * For the full copyright and license information, please read the
 * LICENSE.txt file that was distributed with this source code.
 *
 * The TYPO3 project - inspiring people to share!
 */

use Bk2k\SiteIntroduction\Tests\Acceptance\Support\_generated\AcceptanceTesterActions;

/**
 * Default acceptance tester
*/
class AcceptanceTester extends \Codeception\Actor
{
    use AcceptanceTesterActions;
}
