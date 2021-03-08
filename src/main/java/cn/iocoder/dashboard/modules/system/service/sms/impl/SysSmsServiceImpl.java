package cn.iocoder.dashboard.modules.system.service.sms.impl;

import cn.iocoder.dashboard.framework.sms.client.AbstractSmsClient;
import cn.iocoder.dashboard.framework.sms.core.SmsBody;
import cn.iocoder.dashboard.modules.system.mq.producer.sms.SmsProducer;
import cn.iocoder.dashboard.modules.system.service.sms.SysSmsChannelService;
import cn.iocoder.dashboard.modules.system.service.sms.SysSmsQueryLogService;
import cn.iocoder.dashboard.modules.system.service.sms.SysSmsService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 短信日志Service实现类
 *
 * @author zzf
 * @date 2021/1/25 9:25
 */
@Service
public class SysSmsServiceImpl implements SysSmsService {

    @Resource
    private SysSmsChannelService channelService;

    @Resource
    private SysSmsQueryLogService logService;

    @Resource
    private SmsProducer smsProducer;

    @Override
    public void send(SmsBody smsBody, List<String> targetPhones) {
        AbstractSmsClient client = channelService.getSmsClient(smsBody.getTemplateCode());
        logService.beforeSendLog(smsBody, targetPhones, client);
        smsProducer.sendSmsSendMessage(smsBody, targetPhones);
    }

    // TODO FROM 芋艿 to ZZF：可能要讨论下，对于短信发送来说，貌似只提供异步发送即可。对于业务来说，一定不能依赖短信的发送结果.

}
