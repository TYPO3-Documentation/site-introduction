<?php
declare(strict_types = 1);
namespace Bk2k\SiteIntroduction\Tests\Acceptance\Frontend;

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

use Bk2k\SiteIntroduction\Tests\Acceptance\Support\AcceptanceTester;

/**
 * Tests clicking through some frontend pages
 */
class FrontendPagesCest
{
    /**
     * @param AcceptanceTester $I
     */
    public function firstPageIsRendered(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->see('Open source, enterprise CMS delivering  content-rich digital experiences on any channel,  any device, in any language');
        $I->click('Customize');
        $I->see('Incredible flexible');
    }
}
